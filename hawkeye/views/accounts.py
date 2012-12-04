'''
Created on Dec 3, 2012

@author: superizer
'''

def login(request):
    print("This is login : ", request)
    result = dict()
    if len(request.matchdict) > 0:
        if len(request.matchdict.get('username')) > 0:
            print('username: ', request.matchdict['username'])
            return request.route_url('/')
        result['message'] = "username required"
    
    return result