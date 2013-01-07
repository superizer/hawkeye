'''
Created on Dec 3, 2012

@author: superizer
'''

import os
import configparser


class Configuration:
    '''
    classdocs
    '''

    def __init__(self, config_file):
        self.config_file = config_file
        self.settings = dict()
        self.route = dict()
        self.current_project_path = os.path.dirname(__file__)
        self.current_route_path = None
        
        self.__parse()

    def __parse(self):
        config_parser = configparser.ConfigParser()
        config_parser.read(self.config_file)
        
        sections = ["hawkeye"]

        boolean_conf    = ['debug']
        integer_conf    = ['nokkhum.api.port']
        
        
        for key in boolean_conf:
            self.settings[key] = False
        
        for section in sections:
            if not config_parser.has_section(section):
                continue
            
            for k, v in config_parser.items(section):
                if k in boolean_conf:
                    self.settings[k] = config_parser.getboolean(section, k)
                elif k in integer_conf:
                    self.settings[k] = config_parser.getint(section, k)
                else:
                    self.settings[k] = v.replace("hawkeye:", self.current_project_path+"/")
        
        if 'nokkhum.api.protocal' not in self.settings.keys():
            self.settings['nokkhum.api.protocal'] = 'http'
        if 'nokkhum.api.host' not in self.settings.keys():
            self.settings['nokkhum.api.host'] = 'localhost'
        if 'nokkhum.api.port' not in self.settings.keys():
            self.settings['nokkhum.api.port'] = 6543
            
        self.settings['nokkhum.api.url'] = "%s://%s:%d" % (self.settings['nokkhum.api.protocal'], self.settings['nokkhum.api.host'], self.settings['nokkhum.api.port'])
        
        
    
    def add_route(self, name, action, renderer=None):
        self.route[name] = dict(
                                name=name,
                                action=action,
                                renderer=renderer
                                )
    def get_route(self, name):
        return self.route.get(name, None)