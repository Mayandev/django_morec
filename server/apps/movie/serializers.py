#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-19 21:49
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : serializers.py
# @Software: PyCharm

from rest_framework import serializers
from .models import Movie, Genre


class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        model = Movie
        fields = '__all__'


class GenreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Genre
        fields = '__all__'
