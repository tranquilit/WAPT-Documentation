# -*- coding: utf-8 -*-
from setuphelpers import *

uninstallkey = ["{8B9896FC-B4F2-44CD-8B6E-78A0B1851B59}"]

def install():
    print('installing tis-tightvnc')
    run(r'"tightvnc-2.8.5-gpl-setup-64bit.msi" /q /norestart') 
