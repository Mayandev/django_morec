#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-28 20:52
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : genrate_recommendation.py
# @Software: PyCharm

import os;

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "morec.settings")  # NoQA
import django;

django.setup()  #

from users.models import UserProfile
from movie.models import Genre, Movie
from user_operation.models import UserFavorGenre, UserFavorActor, UserFavorMovie
from recommendation.models import Recommendation

import random


def recommend_genre_sim_movie(user):
    genres =  UserFavorGenre.objects.get(user=user).genre.split(',')

    for id in genres:
        genre_item = Genre.objects.get(id=id)
        description = '根据你喜欢的电影类型「%s」推荐' % (genre_item.genre)
        relate_movies = genre_item.doubanIds.split(',')
        print(relate_movies)
        for id in relate_movies:
            try:
                Recommendation.objects.create(user=user, description=description, doubanId=id, random_rank=random.random())
            except:
                continue



def recommend_actor_sim_movie(user):
    actors = UserFavorActor.objects.filter(user=user)

    for actor in actors:
        description = '根据你喜欢的演员「%s」推荐' % (actor.name)
        works = actor.works.split(',')
        print(works)
        for id in works:
            try:
                Recommendation.objects.create(user=user, description=description, doubanId=id,random_rank=random.random())
            except:
                continue

def recommend_movie_sim_movie(user):
    movies = UserFavorMovie.objects.filter(user=user)

    for movie in movies:
        doubanId = movie.doubanId
        sim_movie = Movie.objects.get(doubanId=doubanId).closest_movie.split(',')
        description = '根据你喜欢的电影「%s」推荐' % (movie.title)
        for id in sim_movie:
            try:
                Recommendation.objects.create(user=user, description=description, doubanId=id,random_rank=random.random())
            except:
                continue




users = UserProfile.objects.filter(is_staff=0, is_superuser=0)

for user in users:
    recommend_genre_sim_movie(user)
    recommend_actor_sim_movie(user)
    recommend_movie_sim_movie(user)


