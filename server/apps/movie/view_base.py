#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-19 21:16
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : view_base.py
# @Software: PyCharm

from django.views.generic import View
from .models import Movie
from django.http import HttpResponse
import json


class MovieList(View):
    def get(self, request):
        # 通过django 的 view 实现视频列表页
        json_list = []
        # 获取电影列表
        movies = Movie.objects.all()
        for movie in movies:
            json_dic = {}
            # 获取电影每个字段
            json_dic['title'] = movie.title
            json_dic['id'] = movie.id
            json_list.append(json_dic)

        return HttpResponse(json.dumps(json_list), content_type='application/json', charset='utf-8')
