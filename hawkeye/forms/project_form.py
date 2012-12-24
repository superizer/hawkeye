'''
Created on Dec 8, 2012

@author: superizer
'''
from wtforms import fields
from wtforms import validators
from . import AbstactForm

class ProjectForm(AbstactForm):
    project    = fields.SelectField('Project', coerce=int, validators=[validators.required(message="Project is required.")])
    
class AddProjectForm(AbstactForm):
    name     = fields.TextField('Name', validators=[validators.required(message="Name is required.")])
    description = fields.TextAreaField('Description') 

class EditProjectForm(AbstactForm):
    name     = fields.TextField('Name', validators=[validators.required(message="Name is required.")])
    description = fields.TextAreaField('Description') 
    
class AddCameraForm(AbstactForm):
    name     = fields.TextField('Name', validators=[validators.required(message="Name is required.")])
    url = fields.TextField('Url', [validators.Required(message="Username is required.")])
    username = fields.TextField('User Name', [validators.Required(message="Username is required.")])
    password = fields.TextField('New Password', [validators.Required(message="Password is required.")])
    fps = fields.SelectField('Fps', coerce=int, validators=[validators.required(message="Fps is required.")])
#    image_size = fields.SelectField('Image Size', coerce=int, validators=[validators.required(message="Image Size is required.")])
#    manufactory = fields.SelectField('Menu Factory', coerce=int, validators=[validators.required(message="Menu Factoryt is required.")])
#    model = fields.SelectField('Model', coerce=int, validators=[validators.required(message="Model is required.")])
    record_store = fields.TextField('Record_store')
