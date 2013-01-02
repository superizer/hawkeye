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
    fps = fields.SelectField('Fps', choices=[('1', '1'),('2', '2'),('3', '3'),('4', '4'),('5', '5'),('6', '6'),('7', '7'),('8', '8'),('10', '10'),('12', '12'),('14', '14'),
                                             ('16', '16'),('18', '18'),('20', '20'),('22', '22'),('24', '24'),('26', '26'),('28', '28'),('30', '30')])
    image_size = fields.SelectField('Image Size', choices=[('320x240', '320x240'), ('640x480', '640x480')])
    #manufactory = fields.SelectField('Menu Factory', choices=[('Generic', 'Generic')])
    manufactory = fields.SelectField('Menu Factory')
    #model = fields.SelectField('Model', choices=[('OpenCV', 'OpenCV')])
    model = fields.SelectField('Model')
    record_store = fields.TextField('Record_store')
