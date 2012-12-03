#!/usr/bin/python3
'''
Created on Dec 2, 2012

@author: superizer
'''

from hawkeye import application
from hawkeye import config
from hawkeye import routing


if __name__ == '__main__':
    config = config.Configuration()
    routing.add_route(config)
    app = application.Application(config)
    app.start()