'''
Created on Dec 3, 2012

@author: superizer
'''
from .views import accounts

def add_route(config):
    config.add_route('/', accounts.login, '/welcome/index.mako')
    config.add_route('/login', accounts.login, '/accounts/login.mako')