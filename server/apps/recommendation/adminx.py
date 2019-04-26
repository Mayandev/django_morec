#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-26 19:24
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : adminx.py
# @Software: PyCharm


import xadmin
from .models import Recommendation


class RecommendationAdmin(object):
    list_display = ['user', 'doubanId', 'description']
    model_icon = 'fa fa-heart'



xadmin.site.register(Recommendation, RecommendationAdmin)