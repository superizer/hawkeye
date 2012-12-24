'''
Created on Dec 3, 2012

@author: superizer
'''

from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtWebKit import *
from PyQt4.QtNetwork import *

import logging
logger = logging.getLogger(__name__)

from mako.template import Template
from mako.lookup import TemplateLookup

import os 

from . import context

class HawkeyeWebPage(QWebPage):
    formSubmitted = pyqtSignal(QUrl)

    def acceptNavigationRequest(self, frame, req, nav_type):
        if nav_type == QWebPage.NavigationTypeFormSubmitted:
            self.formSubmitted.emit(req.url())
            
        return super(HawkeyeWebPage, self).acceptNavigationRequest(frame, req, nav_type)

class Window(QWidget):
    
    session = dict()
    
    def __init__(self, config):
        super(Window, self).__init__()
        
        self.config = config
        
        self.base_url = QUrl.fromLocalFile(os.path.dirname(__file__)+"/")
        
        # initial web view abd handle all link
        self.web_view = QWebView(self)
        self.web_view.setPage(HawkeyeWebPage())
        self.web_view.page().setLinkDelegationPolicy(QWebPage.DelegateAllLinks)
        self.web_view.connect(self.web_view, SIGNAL("linkClicked(const QUrl&)"), self.link_clicked)
        self.web_view.page().formSubmitted.connect(self.handleFormSubmitted)
        
        # initial template lookup
        self.tempalte_lookup = TemplateLookup(directories=[self.config.settings.get("mako.directories")],
                                 module_directory=self.config.settings.get("mako.module_directory"))
        
        # layout attribute
        layout = QVBoxLayout(self)
        layout.setMargin(0) 
        
        # add debug inspector
        if self.config.settings.get("debug", False):
            self.setupInspector()
            self.splitter = QSplitter(self)
            self.splitter.setOrientation(Qt.Vertical)
            layout.addWidget(self.splitter)
            self.splitter.addWidget(self.web_view)
            self.splitter.addWidget(self.webInspector)
        
        else:
            layout.addWidget(self.web_view)
            

    def setupInspector(self):
        '''
            This code from http://agateau.com/2012/02/03/pyqtwebkit-experiments-part-2-debugging/
        '''
        page = self.web_view.page()
        page.settings().setAttribute(QWebSettings.DeveloperExtrasEnabled, True)
        self.webInspector = QWebInspector(self)
        self.webInspector.setPage(page)

        shortcut = QShortcut(self)
        shortcut.setKey(Qt.Key_F12)
        shortcut.activated.connect(self.toggleInspector)
        self.webInspector.setVisible(False)

    def toggleInspector(self):
        self.webInspector.setVisible(not self.webInspector.isVisible())

        
    def handleFormSubmitted(self, qurl):
        elements = {}
        print("\n\ngot url: ", qurl)
        for key, value in qurl.queryItems():
            elements[key] = value
            
        self.render(qurl.path(), elements)
        # do stuff with elements...
#        for item in elements.items():
#            print ("got: ", item)
            
    
    def link_clicked(self, qurl):  
        elements = {}
#        print("got url: ", qurl)
        for key, value in qurl.queryItems():
            elements[key] = value
            
        self.render(qurl.path(), elements)
        #self.render(qurl.path())
        
        
    def render(self, url, args=None):
        #print("url: ", url)
        logger.debug("url: %s" % url)
        view = self.config.get_route(url)
        
        if view is not None:
            action = view.get('action')
            context_obj = context.ResourceContext(self.config, self.session)
            context_obj.add_args(args)
            try:
                response = action(context_obj)
            except Exception as e:            
                if e.args[0] == 'Request Exit':
                    qApp.closeAllWindows()
                    return  
                          
                logger.exception(e)
                #need error page
                return ('/home')

            
            if not isinstance(response, dict):
                if isinstance(response, QUrl):
                    url = response.path()
                    return self.render(url)
#                else:
#                    # need error page
#                    return self.render('/login')
            
            logger.debug("response: %s"%response)
                
            template = self.tempalte_lookup.get_template(
                            self.config.get_route(url).get('renderer')
                            )
            
            html = template.render(**response)
            
            self.web_view.setHtml(html, self.base_url)
            #self.web_view.load(a)
        
    def welcome(self):
        self.render('/login')
