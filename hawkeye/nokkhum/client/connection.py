'''
Created on Dec 5, 2012

@author: superizer
'''
import requests
import json

from .account import Account
from .camera import Camera

class Connection:
    def __init__(self, host, port=80):
        self.host = host
        self.port = port
        
        self.url = 'http://%s:%d' %(self.host,self.port)
        
        self.account = Account(self.url)
        self.camera = Camera(self.url)

        
    
        
        

