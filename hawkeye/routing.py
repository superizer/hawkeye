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
    config.add_route('/camera/add', camera.add, '/camera/add-camera.mako')
    config.add_route('/camera/edit', camera.edit, '/camera/edit-camera.mako')
    config.add_route('/camera/delete', camera.delete)
    config.add_route('/project/add', accounts.add, '/project/add-project.mako')
    config.add_route('/project/edit',accounts.edit, '/project/edit-project.mako')
    config.add_route('/project/delete', accounts.delete)
    config.add_route('/profile', accounts.profile, '/accounts/profile.mako')
    config.add_route('/login', accounts.login, '/accounts/login.mako')
    config.add_route('/logout', accounts.logout)
    config.add_route('/register', accounts.register, '/accounts/register.mako')
    config.add_route('/exit', home.exit_)
    config.add_route('/live',camera.live,'/welcome/live.mako')