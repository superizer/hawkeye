'''
Created on Dec 3, 2012

@author: superizer
'''
import sys
from hawkeye.forms import account_form
from hawkeye.forms import project_form

def index(request):
    form = project_form.ProjectForm(request.matchdict)
    form.pform.choices=[('Record', 'Record'), ('Detect', 'Detect'), ('View', 'View')]
    #form.pform.choices.append(('test','test'))
    return dict(
                    form = form
                    )
def exit_(request):
    raise Exception('Request Exit')
    return {}