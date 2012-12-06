'''
Created on Dec 3, 2012

@author: superizer
'''
import sys
def index(request):
    return {}

def exit_(request):
    raise Exception('Request Exit')
    return {}