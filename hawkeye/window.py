'''
Created on Dec 3, 2012

@author: superizer
'''

from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtWebKit import *
from PyQt4.QtNetwork import *

from mako.template import Template
from mako.lookup import TemplateLookup

from . import contact

class MyWebPage(QWebPage):
    formSubmitted = pyqtSignal(QUrl)

    def acceptNavigationRequest(self, frame, req, nav_type):
        if nav_type == QWebPage.NavigationTypeFormSubmitted:
            self.formSubmitted.emit(req.url())
            
        return super(MyWebPage, self).acceptNavigationRequest(frame, req, nav_type)

class Window(QWidget):
    def __init__(self, config):
        super(Window, self).__init__()
        self.web_view = QWebView(self)
        self.web_view.setPage(MyWebPage())
        self.web_view.page().setLinkDelegationPolicy(QWebPage.DelegateAllLinks)
        
        self.config = config
        
        self.tempalte_lookup = TemplateLookup(directories=[self.config.setting.get("mako.directories")],
                                 module_directory=self.config.setting.get("mako.module_directory"))
        
        self.web_view.page().formSubmitted.connect(self.handleFormSubmitted)
       
        self.web_view.connect(self.web_view, SIGNAL("linkClicked(const QUrl&)"), self.link_clicked)

        layout = QVBoxLayout(self)
        layout.setMargin(0) 
        layout.addWidget(self.web_view)
        
    def handleFormSubmitted(self, url):
        elements = {}
#        print("got url: ", url)
        for key, value in url.queryItems():
            elements[key] = value
            
        self.render(url.path(), elements)
        # do stuff with elements...
#        for item in elements.items():
#            print ("got: ", item)
            
    
    def link_clicked(self, qurl):  
        self.render(qurl.path())
        
    def render(self, url, args=None):
        print("url: ", url)
        view = self.config.get_route(url)
        
        if view is not None:
            action = view.get('action')
            contact_obj = contact.ResourceContact()
            contact_obj.add_args(args)
            response = action(contact_obj)
            
            print("response: ", response)
            if not isinstance(response, dict):
                url = response.path()
                contact_obj = contact.ResourceContact()
                response = action(contact_obj)
                print("response->: ", response)
                
            template = self.tempalte_lookup.get_template(
                            self.config.get_route(url).get('renderer')
                            )
            
            html = template.render(**response)
            self.web_view.setHtml(html, QUrl('qrc:///'))
        
    def welcome(self):
        self.render('/')
        
    def test(self):
        for i in range(10):
            print('test ')