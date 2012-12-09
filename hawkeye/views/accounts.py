'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.forms import project_form

import logging
logger = logging.getLogger(__name__)

def login(request):

    print("This is login : ", request.matchdict)
    
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
        print ('data:', data)
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
        print('add', name)
    else:
        return dict(
                    form = form
                    )
    
    try:
        data = request.nokkhum_client.account.add_project(name, description)
        print ('add data:', data)
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
    form = project_form.ProjectForm(request.matchdict)
    #form.pform.choices.append(('test','test'))
    data = request.nokkhum_client.account.show_project()
    
    form.project.choices = [(project['id'], project['name']) for project in data['projects'] ]
    print('mathdict ', request.matchdict)
    print('--> :  ', form.project.choices)

    if len(request.matchdict) > 0 and form.validate():
        project_id = form.data.get('project')
        #print('project id', project_id)
        request.nokkhum_client.account.delete_project(project_id)
        return request.route_path('/home')
        
    else:
        return dict(
                    form = form
                    )
    return request.route_path('/home')