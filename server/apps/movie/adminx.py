#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-19 20:45
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : adminx.py
# @Software: PyCharm

import xadmin
from .models import Movie, Genre


class MovieAdmin(object):
    list_display = ['id', 'title', 'doubanId']
    model_icon = 'fa fa-ticket'



class GenreAdmin(object):
    list_display = ['id', 'genre']
    model_icon = 'fa fa-ticket'



xadmin.site.register(Movie, MovieAdmin)
xadmin.site.register(Genre, GenreAdmin)

