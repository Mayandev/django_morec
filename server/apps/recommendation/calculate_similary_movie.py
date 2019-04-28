#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-27 11:14
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @Software: PyCharm


import os;

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "morec.settings")  # NoQA
import django;

django.setup()  #

import pandas as pd
import numpy as np
from scipy.sparse import csr_matrix
from sklearn.neighbors import NearestNeighbors
from sklearn.decomposition import TruncatedSVD

from movie.models import Movie

# 使用svd进行电影推荐，找出最接近的top10电影，插入数据库
path = '/Users/phillzou/code_workspace/flutter/django_morec/server/dataset/'


movies = pd.read_csv(path + 'movies.csv')
print('电影数目（有名称）：%d' % movies[~pd.isnull(movies.title)].shape[0])
print('电影数目（没有名称）：%d' % movies[pd.isnull(movies.title)].shape[0])
print('电影数目（总计）：%d' % movies.shape[0])


ratings = pd.read_csv(path + 'ratings.csv')
print('用户数据：%d' % ratings.userId.unique().shape[0])
print('评分数目：%d' % ratings.shape[0])

links = pd.read_csv(path + 'links.csv')

combine_movie_rating= pd.merge(ratings,movies,on='movieId')
combine_movie_rating=combine_movie_rating.drop(['timestamp'],axis = 1)
print(len(combine_movie_rating))

movie_rating_count=pd.DataFrame(combine_movie_rating.
                    groupby(['movieId'])['rating'].
                    count().
                    reset_index().
                    rename(columns={'rating':'totalRatingCount'})
                   )

rating_with_totalRatingCount = combine_movie_rating.merge(movie_rating_count,left_on='movieId',right_on='movieId')

popular_threshold=50
rating_popular_movies= rating_with_totalRatingCount.query('totalRatingCount>=@popular_threshold')


# 构造评分矩阵
ratings_pivot = rating_popular_movies.pivot(index='userId', columns='movieId',values='rating').fillna(0)
ratings_pivot_sparse = csr_matrix(ratings_pivot.values)
print(ratings_pivot.shape)
ratings_pivot.head()

X=ratings_pivot.values.T

svd=TruncatedSVD(n_components=10,random_state=17)
matrix=svd.fit_transform(X)
matrix.shape

corr=np.corrcoef(matrix)

movieIds = ratings_pivot.columns
movieIds_list = list(movieIds)


movie_items = Movie.objects.all();

for movie in movie_items:
    movieId_index = movieIds_list.index(int(movie.movieId))
    movieId_vec = corr[movieId_index]
    argsort_idx = np.argsort(-movieId_vec)[:11]
    coff = movieId_vec[argsort_idx]
    similar_movie_Ids = movieIds[argsort_idx]
    closest_movies = []
    for index in range(len(similar_movie_Ids)):
        if index==0:
            continue
        id = similar_movie_Ids[index]
        doubanId = Movie.objects.get(movieId=id).doubanId
        closest_movies.append(doubanId)
    print(closest_movies)
    divide_tag = ','
    ids = divide_tag.join(closest_movies)
    Movie.objects.filter(movieId=movie.movieId).update(closest_movie=ids)


