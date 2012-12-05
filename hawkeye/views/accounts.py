'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form

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

    
    return request.route_url('/')

def register(request):
    result = dict()
    print('register')
    return result