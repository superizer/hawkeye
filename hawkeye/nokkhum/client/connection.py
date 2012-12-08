'''
Created on Dec 5, 2012

@author: superizer
'''
import requests
import json

from .account import Account

class Connection:
    def __init__(self, host, port=80):
        self.host = host
        self.port = port
        
        self.url = 'http://%s:%d' %(self.host,self.port)
        
        self.account = Account(self.url)

        
    
        
        

