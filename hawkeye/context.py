'''
Created on Dec 4, 2012

@author: boatkrap
'''


from PyQt4.QtCore import QUrl

class MyDict(dict):
    def getlist(self, name):
        return [self.get(name)]

class ResourceContact:
    def __init__(self):
        ''''''
        self.matchdict = MyDict()
    
    def route_url(self, name):
        return QUrl(name)
    
    def route_path(self, name):
        return QUrl(name)
    
    def add_args(self, args):
        if args is not None:
            self.matchdict.update(args)