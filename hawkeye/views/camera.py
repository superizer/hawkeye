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
    id = int(request.matchdict.get('id'))
    if len(request.matchdict) > 1 and form.validate():
        id = int(request.matchdict.get('id'))
        name = form.data.get('name')
        url = form.data.get('url')
        username = form.data.get('username')
        password = form.data.get('password')
        fps = form.data.get('fps')
        image_size = form.data.get('image_size')
        manufactory = form.data.get('menufactory')
        model = form.data.get('model')
        record_store = form.data.get('record_store')
        return request.route_path('/home')
    else:
        data = request.nokkhum_client.account.get_project(id)
        project = data['project']
        return dict(
                    form = form,
                    project = project
                    )
    
    return request.route_path('/home')

def live(request):
    return request.route_url('http://www.google.com')