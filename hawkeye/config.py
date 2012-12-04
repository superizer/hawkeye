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
        self.setting = dict()
        self.route = dict()
        self.current_project_path = os.path.dirname(__file__)
        
        self.__parse()

    def __parse(self):
        config_parser = configparser.ConfigParser()
        config_parser.read(self.config_file)
        
        sections = ["hawkeye"]

        boolean_conf    = []
        integer_conf    = []
        
        
        for key in boolean_conf:
            self.setting[key] = False
        
        for section in sections:
            if not config_parser.has_section(section):
                continue
            
            for k, v in config_parser.items(section):
                if k in boolean_conf:
                    self.setting[k] = config_parser.getboolean(section, k)
                elif k in integer_conf:
                    self.setting[k] = config_parser.getint(section, k)
                else:
                    self.setting[k] = v.replace("hawkeye:", self.current_project_path+"/")
    
    def add_route(self, name, action, renderer=None):
        self.route[name] = dict(
                                name=name,
                                action=action,
                                renderer=renderer
                                )
    def get_route(self, name):
        return self.route.get(name, None)