'''
Created on Dec 4, 2012

@author: boatkrap
'''


from PyQt5.QtCore import QUrl
from hawkeye.nokkhum.client import connection
class MyDict(dict):
    def getlist(self, name):
        return [self.get(name)]

class ResourceContext:
    def __init__(self, config, session):
        ''''''
        self.config = config
        self.matchdict = MyDict()
        self.nokkhum_client = connection.Connection(self.config.settings.get('nokkhum.api.host'),self.config.settings.get('nokkhum.api.port'))
        self.session = session
    
    def route_url(self, name):
        return QUrl(name)
    
    def route_path(self, name):
        return QUrl(name)
    
    def add_args(self, args):
        if args is not None:
            self.matchdict.update(args)
            
    def remember(self, args):
        if 'access' in args:
            self.session.update(args['access'])
            
    def forget(self):
        del self.session['token']
        del self.session['user']