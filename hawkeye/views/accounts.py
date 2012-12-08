'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.nokkhum.client import connection 

def login(request):

    print("This is login : ", request.matchdict)
    form = account_form.AccountForm(request.matchdict)
    
    if len(request.matchdict) > 0 and form.validate():
        email = form.data.get('email')
        password = form.data.get('password')
        
    else:
        return dict(
                    form = form
                    )

        
    try:
        con = connection.Connection()
        data = con.authentication(email, password)
        print ('data:', data)
        if 'access' not in data:
            raise 'error'
    except Exception as e:
        print('error: ', e)
        return dict(
                    message='Passwords mismatch',
                    form = form
                    )
        
    return request.route_url('/home')

def register(request):
    result = dict()
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
        
    return request.route_path('/login')