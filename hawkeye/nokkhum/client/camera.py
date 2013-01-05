import json
import requests

import hawkeye.window

class Camera:
    def __init__(self,url):
        self.url = url
        self.headers = {'content-type': 'application/json'}
    
    def list_manufactory(self):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/manufactories'  , headers=self.headers)
        return r.json
    
    def list_model(self,id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/camera_models/' + str(id)  , headers=self.headers)
        return r.json
    
    def add_camera(self, name, username, password, url, image_size, fps, storage_periods, project_id):
        payload = {'camera': { 'name' : name, 'username' : username, 'password' : password, 'url' : url, 'image_size' : image_size
                              , 'fps' : fps, 'storage_periods' : storage_periods, 'project' : {'id':project_id}, 'user':{'id':hawkeye.window.Window.session['user']['id']}}}
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.post(self.url + '/cameras' , data=json.dumps(payload), headers=self.headers)
        return r.json
    
    def delete_camera(self, id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.delete(self.url + '/cameras/'+ str(id) , headers=self.headers)
        return r.json
    
    def get_camera(self, id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/cameras/' + str(id) , headers=self.headers)
        return r.json
    
    def edit_camera(self, name, username, password, url, image_size, fps, storage_periods, project_id, camera_id):
        payload = {'camera': { 'name' : name, 'username' : username, 'password' : password, 'url' : url, 'image_size' : image_size
                              , 'fps' : fps, 'storage_periods' : storage_periods, 'project' : {'id':project_id}, 'user':{'id':hawkeye.window.Window.session['user']['id']}}}
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.put(self.url + '/cameras/' + str(camera_id) , data=json.dumps(payload), headers=self.headers)
        return r.json
    
    def edit_camera_json(self, camera_id, payload):
        #print('payload', payload)
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.put(self.url + '/cameras/' + str(camera_id) , data=json.dumps(payload), headers=self.headers)
        return r.json
        
    
    def list_camera(self,id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/projects/' + str(id) + '/cameras', headers=self.headers)
        return r.json
    
    def get_storage(self, id):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + '/storage/' + str(id), headers=self.headers)
        return r.json
    
    def delete_file(self, url):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.delete(self.url + url , headers=self.headers)
        return r.json
    
    def get_file(self, url):
        self.headers['X-Auth-Token'] = hawkeye.window.Window.session['token']['id']
        r = requests.get(self.url + url, headers=self.headers)
        return r.json