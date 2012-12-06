'''
Created on Dec 3, 2012

@author: superizer
'''
from .views import accounts
from .views import home

def add_route(config):
    config.add_route('/', accounts.login, '/accounts/login.mako')
    config.add_route('/home', home.index, '/welcome/index.mako')
    config.add_route('/login', accounts.login, '/accounts/login.mako')
    config.add_route('/register', accounts.register, '/accounts/register.mako')
    config.add_route('/exit', home.exit_)