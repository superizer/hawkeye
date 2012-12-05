'''
Created on Dec 3, 2012

@author: superizer
'''

def login(request):
    print("This is login : ", request)
    result = dict()
    if len(request.matchdict) > 0:
        if len(request.matchdict.get('email')) > 0:
            print('email: ', request.matchdict['email'])
            print('password: ', request.matchdict['password'])
            if request.matchdict['email'] == 'admin' and request.matchdict['password'] == 'adminadmin':
                return request.route_url('/')
        result['message'] = "email required"
    
    return result

def register(request):
    result = dict()
    print('register')
    return result