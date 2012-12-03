'''
Created on Dec 3, 2012

@author: superizer
'''

from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtWebKit import *

from mako.template import Template
from mako.lookup import TemplateLookup

class Window(QWidget):
    def __init__(self, config):
        super(Window, self).__init__()
        self.web_view = QWebView(self)
        self.web_view.page().setLinkDelegationPolicy(QWebPage.DelegateAllLinks)
        
        self.config = config
        
        self.tempalte_lookup = TemplateLookup(directories=['/home/superizer/nokkhum/hawkeye/hawkeye/templates'],
                                 module_directory='/tmp/hawkeye')
        
       
        def link_clicked(url):  
            view = self.config.get_route(url.path())
            
            print ('link clicked: ', view)
            if view is not None:
                action = view.get('action')
                response = action(None)
                template = self.tempalte_lookup.get_template(
                                self.config.get_route(url.path()).get('renderer')
                                )
                
                html = template.render(**response)
                self.web_view.setHtml(html)
                 
                             
        self.web_view.connect(self.web_view, SIGNAL("linkClicked(const QUrl&)"), link_clicked)


        layout = QVBoxLayout(self)
        layout.setMargin(0) 
        layout.addWidget(self.web_view)
        
    def welcome(self):
        view = self.config.get_route('/')
        action = view.get('action')
        response = action(None)
        template = self.tempalte_lookup.get_template(
                        self.config.get_route('/').get('renderer')
                        )
        
        html = template.render(**response)
        self.web_view.setHtml(html)
        
    def test(self):
        for i in range(10):
            print('test ')