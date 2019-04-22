#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-22 09:59
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : permissions.py
# @Software: PyCharm

from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Object-level permission to only allow owners of an object to edit it.
    Assumes the model instance has an `owner` attribute.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Instance must have an attribute named `owner`.
        return obj.user == request.user
