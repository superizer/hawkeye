'''
Created on Dec 3, 2012

@author: superizer
'''

from hawkeye.forms import project_form

def index(request):
    form = project_form.ProjectForm(request.matchdict)
    form.project.choices=[('Record', 'Record'), ('Detect', 'Detect'), ('View', 'View')]
    #form.pform.choices.append(('test','test'))
    if len(request.matchdict) > 0 and form.validate():
        project_id = form.data.get('project')
        print(project_id)
    else:
        return dict(
                    form = form
                    )
        
    # add code hear
    return {}

def exit_(request):
    raise Exception('Request Exit')
    return {}