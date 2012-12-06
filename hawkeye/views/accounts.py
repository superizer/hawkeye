'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form

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
    result = dict()
    form = account_form.RegisterForm(request.matchdict)
    #print('name :',form.data.get('email'))
    return result

def logout(request):
    request.forget()
    return request.route_path('/login')