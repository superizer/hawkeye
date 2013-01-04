'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.forms import project_form

import logging
logger = logging.getLogger(__name__)
#add_camera(self, name, username, password, url, image_size, fps, storage_periods):
def add(request):
    form = project_form.AddCameraForm(request.matchdict)
    data = request.nokkhum_client.camera.list_manufactory()
    manufactory_id = "50d6c5c9f303f90131a98290"
    model_data = request.nokkhum_client.camera.list_model(manufactory_id)
    #print('model_data',model_data)
    form.manufactory.choices = [(manufactory['id'], manufactory['name']) for manufactory in data['manufactories'] ]
    form.model.choices = [(model['id'], model['name']) for model in model_data['camera_models'] ]
    project_id = int(request.matchdict.get('id'))
    #print('project_id',project_id)
    if len(request.matchdict) > 1 and form.validate():
        #project_id = int(request.matchdict.get('id'))
        #print('in if project_id',project_id)
        name = form.data.get('name')
        url = form.data.get('url')
        username = form.data.get('username')
        password = form.data.get('password')
        fps = form.data.get('fps')
        image_size = form.data.get('image_size')
        manufactory = form.data.get('menufactory')
        model = form.data.get('model')
        record_store = form.data.get('record_store')
        d = request.nokkhum_client.camera.add_camera(name, username, password, url, image_size, fps, int(record_store), int(project_id))
        print('add camera',d)
        return request.route_path('/home')
    else:
        data = request.nokkhum_client.account.get_project(project_id)
        project = data['project']
        return dict(
                    form = form,
                    project = project
                    )
    
    return request.route_path('/home')

def edit(request):
    form = project_form.AddCameraForm(request.matchdict)
    data = request.nokkhum_client.camera.list_manufactory()
    manufactory_id = "50d6c5c9f303f90131a98290"
    model_data = request.nokkhum_client.camera.list_model(manufactory_id)
    #print('model_data',model_data)
    project_id = int(request.matchdict.get('project_id'))
    camera_id = int(request.matchdict.get('camera_id'))
    print('project id', project_id)
    print('camera id', camera_id)
    form.manufactory.choices = [(manufactory['id'], manufactory['name']) for manufactory in data['manufactories'] ]
    form.model.choices = [(model['id'], model['name']) for model in model_data['camera_models'] ]
    #print('project_id',project_id)
    if len(request.matchdict) > 1 and form.validate():
        #project_id = int(request.matchdict.get('id'))
        #print('in if project_id',project_id)
        project_id = int(request.matchdict.get('project_id'))
        camera_id = int(request.matchdict.get('camera_id'))
        name = form.data.get('name')
        url = form.data.get('url')
        username = form.data.get('username')
        password = form.data.get('password')
        fps = form.data.get('fps')
        image_size = form.data.get('image_size')
        manufactory = form.data.get('menufactory')
        model = form.data.get('model')
        record_store = form.data.get('record_store')
        d = request.nokkhum_client.camera.edit_camera(name, username, password, url, image_size, fps, int(record_store), int(project_id), int(camera_id))
        print('add camera',d)
        return request.route_path('/home')
    else:
        old_data_camera =request.nokkhum_client.camera.get_camera(camera_id);
        print('old data camera', old_data_camera)
        form.name.data = old_data_camera['camera']['name']
        form.url.data = old_data_camera['camera']['url']
        form.username.data = old_data_camera['camera']['username']
        form.password.data = old_data_camera['camera']['password']
        form.fps.data = old_data_camera['camera']['fps']
        form.image_size.data = old_data_camera['camera']['image_size']
        form.manufactory.data = form.data.get('menufactory')
        form.model.data = form.data.get('model')
        form.record_store.data = old_data_camera['camera']['storage_periods']
        data = request.nokkhum_client.account.get_project(project_id)
        project = data['project']
        return dict(
                    form = form,
                    project = project,
                    camera = { 'id': camera_id }
                    )
    
    return request.route_path('/home')

def delete(request):
    if len(request.matchdict) > 0:
        camera_id = int(request.matchdict.get('camera_id'))
        #print('camera id',camera_id)
        request.nokkhum_client.camera.delete_camera(camera_id)
        return request.route_path('/home')
    else:
        return request.route_path('/home')
    return request.route_path('/home')

def live(request):
    return {}