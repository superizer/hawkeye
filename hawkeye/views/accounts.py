'''
Created on Dec 3, 2012

@author: superizer
'''

def login(request):
    print("This is login : ", request)
    result = dict()
    if len(request.matchdict) > 0:
        if len(request.matchdict.get('usr-email')) > 0:
            print('username: ', request.matchdict['usr-email'])
            print('password: ', request.matchdict['usr-password'])
            if request.matchdict['usr-email'] == 'root@hawkeye.local' and request.matchdict['usr-password'] == 'rootpassword':
                return request.route_url('/')
        result['message'] = "login is icorrect. please try again"
    
    return result