'''
Created on Dec 2, 2012

@author: superizer
'''
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWebKit import *
from PyQt5.QtWidgets import QApplication

from .window import Window
import sys

import logging
logger = logging.getLogger(__name__)

class Application(object):
    '''
    classdocs
    '''
    def __init__(self, config):
        '''
        Constructor
        '''
       
        self.app = QApplication(sys.argv)
#        self.app.setGraphicsSystem("raster");
        self.config = config
        
    def start(self):
        
        window = Window(self.config)
        window.show()
        window.welcome()
        #window.web_view.load(QUrl('<img src="http://admin:123zxc@172.30.235.183/video/mjpg.cgi?.mjpg'))
        return self.app.exec_()
