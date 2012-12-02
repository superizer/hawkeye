'''
Created on Dec 2, 2012

@author: superizer
'''
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtWebKit import *

import sys

class Window(QWidget):
    def __init__(self):
        super(Window, self).__init__()
        self.view = QWebView(self)

        layout = QVBoxLayout(self)
        layout.setMargin(0)
        layout.addWidget(self.view)



class Application(object):
    '''
    classdocs
    '''


    def __init__(self):
        '''
        Constructor
        '''
        self.app = QApplication(sys.argv)
        
    def start(self):
        print("Hello world")
        
        
        window = Window()
        html = "<a href='qqq'>test</a>"
        window.show()
        window.view.setHtml(html)
        #window.view.load(QUrl('http://www.google.com'));
        self.app.exec_()