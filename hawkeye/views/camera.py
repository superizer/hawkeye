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
    data = request.nokkhum_client.camera.list_manufactory()
    #project_id = int(request.matchdict.get('id'))
    project_id = request.matchdict.get('id')
#    print('project_id',project_id)
    camera_json = request.matchdict.get('camera_json')
    print('camera json', camera_json)
    if project_id is None:
        project_id = int(request.matchdict.get('project_id'))
    data = request.nokkhum_client.account.get_project(project_id)
    print('data', data)
    project = data['project']
    if camera_json is not None:
        #print('camera json', camera_json)
        data_json = request.nokkhum_client.camera.add_camera_json(json.loads(camera_json))
        print('data json', data_json)
        return request.route_path('/home')
    return dict(
                project = project
                )
    return request.route_path('/home')

def edit(request):
    data = request.nokkhum_client.camera.list_manufactory()
    project_id = int(request.matchdict.get('project_id'))
    camera_id = int(request.matchdict.get('camera_id'))
    #print('project id', project_id)
    #print('camera id', camera_id)
    old_data_camera =request.nokkhum_client.camera.get_camera(camera_id);
    print('old data camera', old_data_camera)
    data = request.nokkhum_client.account.get_project(project_id)
    project = data['project']
    camera_json = request.matchdict.get('camera_json')
    if camera_json is not None:
        print('camera json', camera_json)
        data_json = request.nokkhum_client.camera.edit_camera_json(camera_id, json.loads(camera_json))
        print('data json', data_json)
        return request.route_path('/home')
    return dict(
                project = project,
                camera = { 'id': camera_id },
                cameras = old_data_camera,
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
#    print('***id', camera_id)
    url = request.matchdict.get('files_url', None)
    print('file url',url)
    route = None
    if url is not None:
        pos = url.rfind('/')
        print('pos ',pos)
        print('url pos', url[:pos])
        if url[:pos] == '/storage/' + str(camera_id):
            data = request.nokkhum_client.camera.get_file(url)
            route = '/camera/storage?camera_id=' + str(camera_id)
        else:
            print(':D')
            data = request.nokkhum_client.camera.get_file(url)
            #pos = url.rfind('/')
            route='/camera/storage?files_url='+ url[:pos] + '&camera_id=' + str(camera_id)
            print ('url: ', route)

    else:
        #id = int(request.matchdict.get('camera_id'))
        #print('***id', id)
        #camera_id = 1
        data = request.nokkhum_client.camera.get_storage(camera_id)
#        print('storage', data)
    return dict(
                files = data['files'],
                route = route,
                camera = camera_id
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
    url = data['camera']['url']
    pos = url.rfind('/')
    url = url[:pos]
    pos = url.rfind('/')
    print('pos',pos)
    url = url[:pos] + '/image/jpeg.cgi?.jpg'
    print('url', url)
    return dict(
                url = url
                )
