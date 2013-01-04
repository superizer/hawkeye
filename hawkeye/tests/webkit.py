'''
Created on Dec 8, 2012

@author: ys
'''
import unittest

from hawkeye import application
from hawkeye import config
from hawkeye.window import Window
from hawkeye import routing

class WebkitTest(unittest.TestCase):


    def setUp(self):
        
        self.config = config.Configuration('../../configuration.conf')
        routing.add_route(self.config)
        
        self.app = application.Application(self.config)


    def tearDown(self):
        pass


    def testTemplate(self):
        
        
        window = Window(self.config)
        window.show()
        
        template = window.tempalte_lookup.get_template(
                            '/welcome/live.mako'
                            )
        response = {
                    }
            
        html = template.render(**response)
        window.web_view.setHtml(html, window.base_url)
        #window.welcome()
        #window.view_view.load(QUrl('http://www.google.com'))
        return self.app.app.exec_()


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()