'''
Created on Dec 6, 2012

@author: superizer
'''

import json
import requests

class Account:
    def __init__(self,url):
        self.url = url
        self.headers = {'content-type': 'application/json'}
        
    def authenticate(self,email, password):
        payload = {'password_credentials': {'password': password, 'email': email}}
        r = requests.post(self.url + '/authentication/tokens' , data=json.dumps(payload), headers=self.headers)
        return r.json
    
    def register(self):
        payload = {}
        r = requests.post(self.url + '/register' , data=json.dumps(payload), headers=self.headers)
        return r.json
    
    def profile(self):
        return {}