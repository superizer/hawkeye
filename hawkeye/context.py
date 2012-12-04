'''
Created on Dec 4, 2012

@author: boatkrap
'''

from PyQt4.QtCore import QUrl

class ResourceContact:
    def __init__(self):
        ''''''
        self.matchdict = dict()
    
    def route_url(self, name):
        return QUrl(name)
    
    def add_args(self, args):
        if args is not None:
            self.matchdict.update(args)