'''
Created on Dec 2, 2012

@author: superizer
'''
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtWebKit import *

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
        self.config = config
        
    def start(self):
        
        window = Window(self.config)
        window.show()
        window.welcome()
        #window.view.load(QUrl('http://www.google.com'))
        return self.app.exec_()