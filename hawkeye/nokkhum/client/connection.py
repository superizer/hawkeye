'''
Created on Dec 5, 2012

@author: superizer
'''
import requests
import json

class Connection:
    def __init__(self):
        self.host = 'localhost'
        self.port = '6543'
        
        self.url = 'http://' + self.host + ':' + self.port
        self.headers = {'content-type': 'application/json'}

        
    def authentication(self,email, password):
        payload = {'password_credentials': {'password': password, 'email': email}}
        r = requests.post(self.url + '/authentication/tokens' , data=json.dumps(payload), headers=self.headers)
        
        return r.json
        
        

