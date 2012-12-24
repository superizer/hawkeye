'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.forms import project_form

import logging
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
        #print ('data:', data)
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
            'user' : request.session['user'],
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
    if len(request.matchdict) > 0 and form.validate():
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