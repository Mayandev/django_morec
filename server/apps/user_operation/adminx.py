#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-22 09:17
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : adminx.py
# @Software: PyCharm

import xadmin
from .models import UserFavorMovie


class UserFavorMovieAdmin(object):
    list_display = ['user', 'title']


xadmin.site.register(UserFavorMovie, UserFavorMovieAdmin)