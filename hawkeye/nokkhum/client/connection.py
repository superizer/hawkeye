'''
Created on Dec 5, 2012

@author: superizer
'''
import requests
import json

from .account import Account

class Connection:
    def __init__(self):
        self.host = 'localhost'
        self.port = '6543'
        
        self.url = 'http://' + self.host + ':' + self.port
        
        self.account = Account(self.url)

        
    
        
        

