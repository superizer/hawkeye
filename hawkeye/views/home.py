'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import project_form

def index(request):
    form = project_form.ProjectForm(request.matchdict)
    #form.pform.choices.append(('test','test'))
    data = request.nokkhum_client.account.show_project()
    print('data', data)
    form.project.choices = [(project['id'], project['name']) for project in data['projects'] ]
    if len(request.matchdict) > 0 and form.validate():
        project_id = form.data.get('project')
        print('project id', project_id)
    else:
        return dict(
                    form = form
                    )
        
    # add code hear
    return {}

def exit_(request):
    raise Exception('Request Exit')
    return {}