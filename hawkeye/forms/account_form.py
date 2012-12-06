from wtforms import fields
from wtforms import fields
from wtforms import validators

from . import AbstactForm

class AccountForm(AbstactForm):
    email       = fields.TextField('Email', validators=[validators.required(), validators.Email()])
    password    = fields.TextField('Password', validators=[validators.required()])
    #name
    #surname
    password = fields.PasswordField('New Password', [Required(), EqualTo('confirm', mesage='Passwords must match')])
    confirm  = fields.PasswordField('Repeat Password')
    