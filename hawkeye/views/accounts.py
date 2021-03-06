'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.forms import project_form

import logging
import hawkeye.window
logger = logging.getLogger(__name__)

def login(request):
    
    #print("This is login : ", request.matchdict)
    
    if request.session.get('user', None):
        return request.route_path('/home')
    
    form = account_form.AccountForm(request.matchdict)
    
    if len(request.matchdict) > 0 and form.validate():
        email = form.data.get('email')
        password = form.data.get('password')
        
    else:
        return dict(
                    form = form
                    )
  
    try:
        data = request.nokkhum_client.account.authenticate(email, password)
        print ('data:', data)
        if 'access' not in data:
            raise 'error'
        
        request.remember(data)
    except Exception as e:
        logger.exception(e)
        return dict(
                    message='Passwords mismatch',
                    form = form
                    )
        
    return request.route_url('/home')

def register(request):
    form = account_form.RegisterForm(request.matchdict)
    if len(request.matchdict) > 0 and form.validate():
        name = form.data.get('name')
        surname = form.data.get('surname')
        email = form.data.get('email')
        password = form.data.get('password')
    else:
        return dict(
                    form = form
                    )
    
    try:
        data = request.nokkhum_client.account.register(name, surname, password, email)
        #print ('data:', data)
        if data is None or 'error' in data:
            raise Exception('error')
        
    except Exception as e:
        logger.exception(e)
        logger.error("error: ", data)
        return dict(
                    message=data.get("error", "Can't Register"),
                    form = form
                    )
        
    return request.route_path('/login')

def logout(request):
    request.forget()
    return request.route_path('/login')

def profile(request):
    form = project_form.ProjectForm(request.matchdict)
    return {
            'user' : request.session['user']
            }
    
def add(request):
    form = project_form.AddProjectForm(request.matchdict)
    if len(request.matchdict) > 0 and form.validate():
        name = form.data.get('name')
        description = form.data.get('description')
        #print('add', name)
    else:
        return dict(
                    form = form
                    )
    
    try:
        data = request.nokkhum_client.account.add_project(name, description)
        #print ('add data:', data)
        if data is None or 'error' in data:
            raise Exception('error')
        
    except Exception as e:
        logger.exception(e)
        logger.error("error: ", data)
        return dict(
                    message=data.get("error", "Can't add project."),
                    form = form
                    )
        
    return request.route_path('/home')

def delete(request):
    if len(request.matchdict) > 0:
        project_id = int(request.matchdict.get('id'))
        request.nokkhum_client.account.delete_project(project_id)
        return request.route_path('/home')
        
    else:
        return dict(
                    form = form
                    )
    return request.route_path('/home')

def edit(request):
    form = project_form.EditProjectForm(request.matchdict)
    id = int(request.matchdict.get('id'))
    if len(request.matchdict) > 1 and form.validate():
        id = int(request.matchdict.get('id'))
        name = form.data.get('name')
        description = form.data.get('description')
        data = request.nokkhum_client.account.edit_project(id, name, description)
        return request.route_path('/home')
    else:
        data = request.nokkhum_client.account.get_project(id)
        project = data['project']
        form.name.data = project['name']
        form.description.data = project['description']
        return dict(
                    form = form,
                    project = project
                    )
    
    return request.route_path('/home')

def controlpanel(request):
    return dict(
                who = request.session['user']['roles'][0]['id']
                )
    
def observe_project(request):
    project_id = int(request.matchdict.get('id'))
#    data = request.nokkhum_client.camera.list_camera(project_id)
#    print("data -->",data['project']['cameras'])
    return dict(
#                data = data['project']['cameras']
                 project_id = project_id
                )
def collaborator_project(request):
    user_id = ""
    data = request.nokkhum_client.account.list_project()
    data_users = request.nokkhum_client.account.list_user()['users']
    filter_id = request.session['user']['id']
#    print('user -->',data_users)
#    print('fuser -->',filter_id)
    for fdata in data_users:
#        print('quser -->',fdata)
        if fdata['id'] is filter_id:
            data_users.remove(fdata)
            break
#    print('data -->',data['projects'])
#    print('user -->',data_users)
    method = str(request.matchdict.get('method',None))
    p_id = request.matchdict.get('p_id',None)
    u_id = request.matchdict.get('u_id',None)
#    print("method ->",method)
#    print("p_id ->",p_id)
#    print("u_id ->",u_id)
    if method is not None:
#        print("ok -> not none")
        if method == "add":
#            print("ok -> add")
            t_data = request.nokkhum_client.account.add_coraborator(p_id,u_id)
#            print("ok ->",t_data)
        elif method == "delete":
#            print("ok -> delete")
            t_data = request.nokkhum_client.account.delete_coraborator(p_id,u_id)
#            print("ok ->",t_data)
#    data = request.nokkhum_client.camera.list_camera(project_id)
#    print("data -->",data['project']['cameras'])
    return dict(
#                data = data['project']['cameras']
                 data = data['projects'],
                 users = data_users
                )