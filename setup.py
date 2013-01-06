import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.txt')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'mako',
    'requests',
    'wtforms'
    ]

SCRIPT_NAME = 'hawkeye'
setup(name='hawkeye',
      version='0.0',
      description='hawkeye nokkhum client',
      long_description=README + '\n\n' +  CHANGES,
      classifiers=[
        "Programming Language :: Python :: 3",
        "Framework :: hawkeye",
        ],
      author='Attasuntorn Traisuwan  Yoschanin Sasiwat, Wongpiti Wangsanti',
      author_email='',
      scripts = ['bin/%s' % SCRIPT_NAME],
      license = 'xxx License',
      packages = find_packages(),
      url='https://github.com/superizer/hawkeye',
      keywords='VSaaS, client',
#      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      install_requires=requires,
#      tests_require=requires,
#      test_suite="nokkhum-controller",
      )

