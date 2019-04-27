#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-27 11:14
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : task.py
# @Software: PyCharm


import os;

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "morec.settings")  # NoQA
import django;

django.setup()  #

import requests
import json

#
# from users.models import UserProfile
#
# users = UserProfile.objects.all().values('id')

