'''
Created on Dec 3, 2012

@author: superizer
'''
from .views import camera
from .views import accounts
from .views import home

def add_route(config):
    config.add_route('index', '/', accounts.login, '/accounts/login.mako')
    config.add_route('home', '/home', home.index, '/welcome/index.mako')
    config.add_route('controlpanel', '/controlpanel', accounts.controlpanel, '/welcome/controlpanel.mako')
    config.add_route('camera_add', '/camera/add', camera.add, '/camera/add-camera.mako')
    config.add_route('camera_edit', '/camera/edit', camera.edit, '/camera/edit-camera.mako')
    config.add_route('camera_storage', '/camera/storage', camera.storage, '/camera/storage.mako')
    config.add_route('camera_files', '/camera/files', camera.files, '/camera/files.mako')
    config.add_route('camera_files_delete', '/camera/files/delete', camera.delete_files)
    config.add_route('camera_delete', '/camera/delete', camera.delete)
    config.add_route('collaborator', '/collaborator', accounts.collaborator_project, '/project/collaborator.mako')
    config.add_route('project_add', '/project/add', accounts.add, '/project/add-project.mako')
    config.add_route('project_edit', '/project/edit',accounts.edit, '/project/edit-project.mako')
    config.add_route('project_delete', '/project/delete', accounts.delete)
    config.add_route('profile', '/profile', accounts.profile, '/accounts/profile.mako')
    config.add_route('login', '/login', accounts.login, '/accounts/login.mako')
    config.add_route('logout', '/logout', accounts.logout)
    config.add_route('register', '/register', accounts.register, '/accounts/register.mako')
    config.add_route('exit', '/exit', home.exit_)
    config.add_route('live', '/live',camera.live,'/welcome/live.mako')
    config.add_route('observe', '/observe',accounts.observe_project,'/welcome/observe.mako')