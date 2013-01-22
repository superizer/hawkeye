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
    form_submitted = pyqtSignal(QUrl, QVariant)
    request_reload = pyqtSignal(QUrl)

    def acceptNavigationRequest(self, frame, req, nav_type):
        
        if nav_type == QWebPage.NavigationTypeFormSubmitted:
            forms = req.originatingObject().findAllElements('form')
            
            def get_attribute_form(inputs, elements):
                for input in inputs:
                    value_str = "this.value"
                    if input.attribute('type') == 'textarea':
                        value_str = "this.text"
                    
                    elements[input.attribute('name')] = input.evaluateJavaScript(value_str)
            
            elements={}
            for form in forms:
                if form.attribute('action') in req.url().path():
                    inputs = form.findAll("input");
                    get_attribute_form(inputs, elements)
                    
                    textareas = form.findAll("textarea");
                    get_attribute_form(textareas, elements)
                    
                    selections = form.findAll("select");
                    get_attribute_form(selections, elements)
                    
                    button = form.findAll("button");
                    get_attribute_form(button, elements)
                    
            
            #print("elements: ", elements)
            self.form_submitted.emit(req.url(), elements)
        if nav_type == QWebPage.NavigationTypeReload:
            self.request_reload.emit(req.url())
            
        return super(HawkeyeWebPage, self).acceptNavigationRequest(frame, req, nav_type)
    
class NetworkAccessManager(QNetworkAccessManager):
    '''
    implement hawkeye new networkrequest with identify user token header, only connect to nokkhum api. 
    '''
    def __init__(self, old_manager, context_obj):

        QNetworkAccessManager.__init__(self)
        self.old_manager = old_manager
        self.setCache(old_manager.cache())
        self.setCookieJar(old_manager.cookieJar())
        self.setProxy(old_manager.proxy())
        self.setProxyFactory(old_manager.proxyFactory())
        self.context_obj = context_obj
        
    def createRequest(self, operation, request, data):
        #print("url: ", request.url())
        api_url = self.context_obj.config.settings['nokkhum.api.url']

        if api_url in request.url().toString():
            if 'token' in self.context_obj.session:
                request.setRawHeader('X-Auth-Token', self.context_obj.session['token']['id'])
            
        
        return QNetworkAccessManager.createRequest(self, operation, request, data)

class Window(QWidget):
    
    session = dict()
    
    def __init__(self, config):
        super(Window, self).__init__()
        
        self.config = config
        
        self.base_url = QUrl.fromLocalFile(os.path.dirname(__file__)).toString()
        
        # initial web view add handle all link and form submitted
        self.web_view = QWebView(self)
        self.web_view.setPage(HawkeyeWebPage())
        self.web_view.page().setLinkDelegationPolicy(QWebPage.DelegateAllLinks)
        self.web_view.connect(self.web_view, SIGNAL("linkClicked(const QUrl&)"), self.link_clicked)
        self.web_view.connect(self.web_view, SIGNAL("urlChanged(const QUrl&)"), self.url_changed)
        self.web_view.connect(self.web_view, SIGNAL("loadFinished(bool)"), self.load_finished)
        self.web_view.connect(self.web_view, SIGNAL("loadStarted()"), self.load_started)
        self.web_view.page().form_submitted.connect(self.handle_form_submitted)
        self.web_view.page().request_reload.connect(self.handle_reload)
        # initial template lookup
        self.tempalte_lookup = TemplateLookup(directories=[self.config.settings.get("mako.directories")],
                                 module_directory=self.config.settings.get("mako.module_directory"))
        
        # layout attribute
        layout = QVBoxLayout(self)
        layout.setMargin(0) 
        
        # add debug inspector
        if self.config.settings.get("debug", False):
            self.setup_inspector()
            self.splitter = QSplitter(self)
            self.splitter.setOrientation(Qt.Vertical)
            layout.addWidget(self.splitter)
            self.splitter.addWidget(self.web_view)
            self.splitter.addWidget(self.web_inspector)
        
        else:
            layout.addWidget(self.web_view)
                
        old_manager = self.web_view.page().networkAccessManager()
        context_obj = context.ResourceContext(self.config, self.session)
        new_manager = NetworkAccessManager(old_manager, context_obj)
        self.web_view.page().setNetworkAccessManager(new_manager)

    def setup_inspector(self):
        '''
            This code from http://agateau.com/2012/02/03/pyqtwebkit-experiments-part-2-debugging/
        '''
        page = self.web_view.page()
        page.settings().setAttribute(QWebSettings.DeveloperExtrasEnabled, True)
        self.web_inspector = QWebInspector(self)
        self.web_inspector.setPage(page)

        shortcut = QShortcut(self)
        shortcut.setKey(Qt.Key_F12)
        shortcut.activated.connect(self.toggle_inspector)
        self.web_inspector.setVisible(False)

    def toggle_inspector(self):
        self.web_inspector.setVisible(not self.web_inspector.isVisible())

        
    def handle_form_submitted(self, qurl, elements=dict()):

 #       print("\n\ngot url: ", qurl)
        for key, value in qurl.queryItems():
            elements[key] = value
            
        self.render(qurl, elements)
        # do stuff with elements...
#        for item in elements.items():
#            print ("got: ", item)

    def handle_reload(self, qurl):
        print("reload ->: ", qurl)
        self.render(qurl)
    
    def load_started(self): 
        ''''''
        # print("load_started ->: ", self.web_view.url())

        
    def load_finished(self, finished): 
        ''''''
        # print("load_finished ->: ", finished)
#        if finished:
#            self.web_view.setUrl(QUrl('/login'))
        
    def url_changed(self, qurl): 
        ''''''
        # print("url_changed ->: ", qurl)
    
    def link_clicked(self, qurl):  
        # print("link_clicked ->: ", qurl)
        elements = {}
        # print("got link_clicked url: ", qurl)
        for key, value in qurl.queryItems():
            elements[key] = value
            
        self.render(qurl, elements)
        #self.render(qurl.path())
        
        
    def render(self, qurl, args=None):
        url = qurl.path()
        self.config.current_route_path = qurl.toString()
        print("url: ", url)
        print("current_route_path: ", self.config.current_route_path)
        logger.debug("url: %s" % url)
        view = self.config.get_route(url)
        # logger.debug("view: %s" % view)
        
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
                    return self.link_clicked(response)
#                    url = response.path()
#                    print('window url', url)
#                    return self.render(url)
#                else:
#                    # need error page
#                    return self.render('/login')
            
            logger.debug("response: %s"%response)
                
            template = self.tempalte_lookup.get_template(
                            self.config.get_route(url).get('renderer')
                            )
            
            response['request'] = context_obj
            response['base_url'] = self.base_url
            html = template.render(**response)
            
            self.web_view.setHtml(html, QUrl("file://"+url))
            
            #self.web_view.load(a)
        
    def welcome(self):
        context_obj = context.ResourceContext(self.config, self.session)
        return self.link_clicked(context_obj.route_path('/login'))
