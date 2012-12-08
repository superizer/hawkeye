'''
Created on Dec 8, 2012

@author: superizer
'''
from wtforms import fields
from . import AbstactForm

class ProjectForm(AbstactForm):
    pform    = fields.SelectField('Programming Language',)
