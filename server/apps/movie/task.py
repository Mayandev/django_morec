#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-27 16:00
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : calculate_similary_movie.py
# @Software: PyCharm

from .models import Genre
import requests


# 定时爬取种类相关电影id
def update_genre_movie():
    genres = Genre.objects.all().values_list('id', 'genre');
    url = " https://api.douban.com/v2/movie/search"

    doubanIds = []

    for genre in genres:
        print(genre[1])
        r = requests.get(url, params={'tag': genre[1]})
        movie_list = r.json()['subjects'];
        print(movie_list)
        for movie in movie_list:
            doubanIds.append(movie['id'])

        divide_tag = ','
        ids = divide_tag.join(doubanIds)
        print(ids)
        Genre.objects.filter(id=genre[0]).update(doubanIds=ids)
        doubanIds = []
