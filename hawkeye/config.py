'''
Created on Dec 3, 2012

@author: superizer
'''

class Configuration:
    '''
    classdocs
    '''


    def __init__(self):
        '''
        Constructor
        '''
        self.route = {}
        
    def add_route(self, name, action, renderer=None):
        self.route[name] = dict(
                                name=name,
                                action=action,
                                renderer=renderer
                                )
    def get_route(self, name):
        return self.route.get(name, None)