'''
Created on Dec 3, 2012

@author: superizer
'''
from .views import accounts
from .views import home

def add_route(config):
    config.add_route('/', home.index, '/welcome/index.mako')
    config.add_route('/login', accounts.login, '/accounts/login.mako')