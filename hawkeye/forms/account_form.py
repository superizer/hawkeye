from wtforms import fields
from wtforms import validators

from . import AbstactForm

class AccountForm(AbstactForm):
    email       = fields.TextField('Email', validators=[validators.required(), validators.Email()])
    password    = fields.TextField('Password', validators=[validators.required()])