'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import account_form
from hawkeye.forms import project_form

import logging
import json
logger = logging.getLogger(__name__)
#add_camera(self, name, username, password, url, image_size, fps, storage_periods):
def add(request):
    #print('ip',request.config.settings.get('nokkhum.api.host'))
    url_api = 'http://' + str(request.config.settings.get('nokkhum.api.host')) + ':' + str(request.config.settings.get('nokkhum.api.port')) 
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
        print('model', model)
        record_store = form.data.get('record_store')
        d = request.nokkhum_client.camera.add_camera(name, username, password, url, image_size, fps, int(record_store), model, int(project_id))
        print('add camera',d)
        return request.route_path('/home')
    else:
        data = request.nokkhum_client.account.get_project(project_id)
        
        project = data['project']
        camera_json = request.matchdict.get('camera_json')
        if camera_json is not None:
            #print('camera json', camera_json)
            data_json = request.nokkhum_client.camera.add_camera_json(json.loads(camera_json))
            print('data json', data_json)
        return dict(
                    form = form,
                    project = project,
                    url_api = url_api
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
    #print('project id', project_id)
    #print('camera id', camera_id)
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
        #print('camera id', camera_id)
#        form.name.data = old_data_camera['camera']['name']
#        form.url.data = old_data_camera['camera']['url']
#        form.username.data = old_data_camera['camera']['username']
#        form.password.data = old_data_camera['camera']['password']
#        form.fps.data = old_data_camera['camera']['fps']
#        form.image_size.data = old_data_camera['camera']['image_size']
#        form.manufactory.data = form.data.get('menufactory')
#        form.model.data = form.data.get('model')
#        form.record_store.data = old_data_camera['camera']['storage_periods']
        data = request.nokkhum_client.account.get_project(project_id)
        project = data['project']
        camera_json = request.matchdict.get('camera_json')
        if camera_json is not None:
            #print('camera json', camera_json)
            data_json = request.nokkhum_client.camera.edit_camera_json(camera_id, json.loads(camera_json))
            #print('data json', data_json)
        return dict(
                    form = form,
                    project = project,
                    camera = { 'id': camera_id },
                    cameras = old_data_camera
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

def storage(request):
    camera_id = int(request.matchdict.get('camera_id'))
    #('***id', camera_id)
    url = request.matchdict.get('files_url', None)
    #print('file url',url)
    route = None
    if url is not None:
        pos = url.rfind('/')
        #print('url pos', url[:pos])
        if url[:pos] == '/storage/' + str(camera_id):
            data = request.nokkhum_client.camera.get_file(url)
            route = '/camera/storage?camera_id=' + str(camera_id)
        else:
            #print(':D')
            data = request.nokkhum_client.camera.get_file(url)
            #pos = url.rfind('/')
            route='/camera/storage?files_url='+ url[:pos] + '&camera_id=' + str(camera_id)
        #print ('url: ', route)

    else:
        #id = int(request.matchdict.get('camera_id'))
        #print('***id', id)
        camera_id = 1
        data = request.nokkhum_client.camera.get_storage(camera_id)
    
    #print('storage', data)
    return dict(
                files = data['files'],
                route = route,
                camera = { 'id': camera_id }
                )  
#/camera/storage?files_url=/storage/1/20121223&camera_id=1
def files(request):
    camera_id = int(request.matchdict.get('camera_id'))
    #print('***id', camera_id)
    #print('matchdict', request.matchdict)
    url = request.matchdict.get('files_url')
    #print('url', url)
    pos = url.rfind('/')
    back_url = url[:pos]
    for i in range (1,7):
        pos = back_url.find('/')
        back_url = back_url[pos:]
        back_url = back_url[1:]
    #pos = url.rfind('/')
    #print('url2', url)
    route='/camera/storage?files_url=/storage/' + back_url + '&' + 'camera_id=' + str(camera_id)
    #print('route', route)
    image = False
    extensions=['.png']
    for extension in extensions:
        if extension in url:
            image = True
            break
        
    return dict(
                url=url,
                image=image,
                route = route,
                camera = { 'id': camera_id }
                )
    
def delete_files(request):
    
    url = request.matchdict.get('files_url')
    #print('url', url)
    data = request.nokkhum_client.camera.delete_file(url)
    #print('delete data', data)
    pos = url.rfind('/')
    route='/camera/storage?files_url='+ url[:pos]
    #print ('url: ', route)
    return request.route_path(route )   
    
def live(request):
    camera_id = int(request.matchdict.get('camera_id'))
    data =request.nokkhum_client.camera.get_camera(camera_id);
    print('url', data['camera']['url'])
    data['camera']['url'] = 'http://admin:123zxc@172.30.235.183/image/jpeg.cgi'
    return dict(
                url = data['camera']['url']
                )
