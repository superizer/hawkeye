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
                    message='password mismatch',
                    form = form
                    )
        
    return request.route_url('/')

def register(request):
    result = dict()
    form = account_form.AccountForm(request.matchdict)
    print('name :',form.data.get('email'))
    return result