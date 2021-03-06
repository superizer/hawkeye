from wtforms import fields
from wtforms import validators

from . import AbstactForm

class AccountForm(AbstactForm):
    email       = fields.TextField('Email', validators=[validators.required(message="Email is required."), validators.Email()])
    password    = fields.PasswordField('Password', validators=[validators.required(message="Passwords is required.")])
    
class RegisterForm(AbstactForm):
    name     = fields.TextField('Name', validators=[validators.required(message="Name is required.")])
    surname  = fields.TextField('Surname', validators=[validators.required(message="Surname is required.")])
    email    = fields.TextField('Email', validators=[validators.required(message="Email is required."), validators.Email()])
    password = fields.PasswordField('New Password', [validators.Required(message="New Password is required."), validators.EqualTo('confirm', message='Passwords must match')])
    confirm  = fields.PasswordField('Repeat Password')
    