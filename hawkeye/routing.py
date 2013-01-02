'''
Created on Dec 3, 2012

@author: superizer
'''
from .views import camera
from .views import accounts
from .views import home

def add_route(config):
    config.add_route('/', accounts.login, '/accounts/login.mako')
    config.add_route('/home', home.index, '/welcome/index.mako')
    config.add_route('/camera/add', camera.add, '/welcome/add-camera.mako')
    config.add_route('/project/add', accounts.add, '/welcome/add-project.mako')
    config.add_route('/project/edit',accounts.edit, '/welcome/edit-project.mako')
    config.add_route('/project/delete', accounts.delete)
    config.add_route('/profile', accounts.profile, '/accounts/profile.mako')
    config.add_route('/login', accounts.login, '/accounts/login.mako')
    config.add_route('/logout', accounts.logout)
    config.add_route('/register', accounts.register, '/accounts/register.mako')
    config.add_route('/exit', home.exit_)
    config.add_route('/live',camera.live,'http://www.google.com')