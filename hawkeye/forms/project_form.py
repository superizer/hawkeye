'''
Created on Dec 8, 2012

@author: superizer
'''
from wtforms import fields
from wtforms import validators
from . import AbstactForm

class ProjectForm(AbstactForm):
    project    = fields.SelectField('Project')
    
class AddProjectForm(AbstactForm):
    name     = fields.TextField('Name', validators=[validators.required(message="Name is required.")])
    description = fields.TextAreaField('Description') 
