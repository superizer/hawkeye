from wtforms import fields
from wtforms import validators

from . import AbstactForm

class AccountForm(AbstactForm):
    email       = fields.TextField('Email', validators=[validators.required(), validators.Email()])
    password    = fields.TextField('Password', validators=[validators.required()])
    #name
    #surname
    
class RegisterForm(AbstactForm):
    password = fields.PasswordField('New Password', [validators.Required(), validators.EqualTo('confirm', mesage='Passwords must match')])
    confirm  = fields.PasswordField('Repeat Password')
    