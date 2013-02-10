'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import project_form

def index(request):
    form = project_form.ProjectForm(request.matchdict)
    #form.pform.choices.append(('test','test'))
    data = request.nokkhum_client.account.list_project()
#    print('-->',data)
    for project in data['projects']:
        project['cameras'] = request.nokkhum_client.camera.list_camera(project['id'])['project']['cameras']
    for collaborator in data['collaborate_projects']:
        collaborator['cameras'] = request.nokkhum_client.camera.list_camera(collaborator['id'])['project']['cameras']
    #print('collaborator',data)
    #camera_in_project = request.nokkhum_client.camera.list_camera();
    #print('camera ', camera_in_project)
    form.project.choices = [(project['id'], project['name']) for project in data['projects'] ]
    project_id = form.data.get('project')
    
    if len(request.matchdict) > 0 and form.validate():
        project_id = form.data.get('project')
        #print('project id', project_id)
    
    else:
        #print('request', data)
        print("This You ->",request.session['user'])
        return dict(
                    form = form,
                    projects=data['projects'],
                    collaborators=data['collaborate_projects'],
                    who = request.session['user']['roles'][0]['name']
                    )
        
    # add code hear
    return {}

def exit_(request):
    raise Exception('Request Exit')
    return {}