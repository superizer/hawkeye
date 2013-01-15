'''
Created on Dec 6, 2012

@author: superizer
'''

import json
import requests

import hawkeye.window

class Account:
    def __init__(self,url):
        self.url = url
        self.headers = {'content-type': 'application/json'}
        
    def authenticate(self, email, password):
        payload = {'password_credentials': {'password': password, 'email': email}}
        r = requests.post(self.url + '/authentication/tokens' , data=json.dumps(payload), headers=self.headers)
        return r.json()
    
    def register(self, name, surname, password, email ):
        payload = {'user': {'first_name' : name, 'last_name' : surname, 'email' : email, 'password' : password }}
        r = requests.post(self.url + '/accounts' , data=json.dumps(payload), headers=self.headers)
        return r.json()
    
    def list_project(self):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/users/' + str(hawkeye.window.Window.session['user']['id']) + '/projects' , headers=self.headers)
        return r.json()
    
    def get_project(self, id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/projects/' + str(id) , headers=self.headers)
        return r.json()
    
    def add_project(self, name, description):
        payload = {'project': {'name' : name, 'description' : description,'user':{'id':hawkeye.window.Window.session['user']['id']}}}
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.post(self.url + '/projects' , data=json.dumps(payload), headers=self.headers)
        return r.json()
    
    def delete_project(self, id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.delete(self.url + '/projects/'+ str(id) , headers=self.headers)
        return r.json()
    
    def edit_project(self, id, name, description):
        payload = {'project': { 'name' : name, 'description' : description,'user':{'id':hawkeye.window.Window.session['user']['id']}}}
        #print('payload', payload)
        #print('id',id)
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.put(self.url + '/projects/'+ str(id) , data=json.dumps(payload), headers=self.headers)
        return r.json()
