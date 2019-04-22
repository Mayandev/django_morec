#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-20 09:46
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : serializers.py
# @Software: PyCharm

from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth import get_user_model


User = get_user_model()


class UserDetailSerializer(serializers.ModelSerializer):
    """
    用户详情
    """
    class Meta:
        model = User
        fields = ("name", "gender", "birthday", "email", "mobile")


class UserRegSerializer(serializers.ModelSerializer):
    # 验证用户名是否存在
    username = serializers.CharField(allow_blank=False,
                                     validators=[UniqueValidator(queryset=User.objects.all(), message="用户已经存在")])

    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('username', 'password')
