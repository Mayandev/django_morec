#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-22 09:17
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : adminx.py
# @Software: PyCharm

import xadmin
from .models import UserFavorMovie, UserFavorActor, UserFavorGenre


class UserFavorMovieAdmin(object):
    list_display = ['user', 'title']
    model_icon = 'fa fa-star'


class UserFavorActorAdmin(object):
    list_display = ['user', 'name']
    model_icon = 'fa fa-star'


class UserFavorGenreAdmin(object):
    list_display = ['user', 'genre']
    model_icon = 'fa fa-star'



xadmin.site.register(UserFavorMovie, UserFavorMovieAdmin)
xadmin.site.register(UserFavorActor, UserFavorActorAdmin)
xadmin.site.register(UserFavorGenre, UserFavorGenreAdmin)