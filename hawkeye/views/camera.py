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
    #print('data', data)
    form.manufactory.choices = [(manufactory['id'], manufactory['name']) for manufactory in data['manufactories'] ]
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
