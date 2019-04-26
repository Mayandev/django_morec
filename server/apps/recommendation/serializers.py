#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-26 19:28
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : serializers.py
# @Software: PyCharm
from rest_framework import serializers
from recommendation.models import Recommendation
from rest_framework.validators import UniqueTogetherValidator


class RecommendationDetailSerializer(serializers.ModelSerializer):
    """
    用户收藏电影详情
    """

    class Meta:
        model = Recommendation
        fields = ['doubanId', 'description']


class RecommendationSerializer(serializers.ModelSerializer):
    # 获取当前登录的用户
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        # validate实现唯一联合，一个电影推荐一次
        validators = [
            UniqueTogetherValidator(
                queryset=Recommendation.objects.all(),
                fields=('user', 'doubanId'),
                # message的信息可以自定义
                message="已经推荐过此电影"
            )
        ]
        model = Recommendation
        fields = ("user", "doubanId", 'description')
