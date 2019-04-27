#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-22 09:32
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : serializers.py
# @Software: PyCharm

from rest_framework import serializers
from user_operation.models import UserFavorMovie, UserFavorActor, UserFavorGenre
from rest_framework.validators import UniqueTogetherValidator


class UserFavorMovieDetailSerializer(serializers.ModelSerializer):
    """
    用户收藏电影详情
    """

    class Meta:
        model = UserFavorMovie
        fields = ['doubanId', 'title', 'poster']


class UserFavorActorDetailSerializer(serializers.ModelSerializer):
    """
    用户收藏演员详情
    """

    class Meta:
        model = UserFavorActor
        fields = ['actorId', 'name', 'avatar']


class UserFavorMovieSerializer(serializers.ModelSerializer):
    # 获取当前登录的用户
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        # validate实现唯一联合，一个电影只能收藏一次
        validators = [
            UniqueTogetherValidator(
                queryset=UserFavorMovie.objects.all(),
                fields=('user', 'doubanId'),
                # message的信息可以自定义
                message="已经收藏此电影"
            )
        ]
        model = UserFavorMovie
        fields = ("user", "doubanId", 'title', 'poster')


class UserFavorActorSerializer(serializers.ModelSerializer):
    # 获取当前登录的用户
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        # validate实现唯一联合，一个演员只能收藏一次
        validators = [
            UniqueTogetherValidator(
                queryset=UserFavorActor.objects.all(),
                fields=('user', 'actorId'),
                # message的信息可以自定义
                message="已经收藏此演员"
            )
        ]
        model = UserFavorActor
        fields = ("user", "actorId", 'name', 'avatar', 'works')


class UserFavorGenreSerializer(serializers.ModelSerializer):
    # 获取当前登录的用户
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = UserFavorGenre
        fields = ("user", "genre")
