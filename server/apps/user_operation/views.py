from django.shortcuts import render

# Create your views here.

from rest_framework import viewsets
from rest_framework import mixins
from .models import UserFavorMovie, UserFavorActor
from .serializers import UserFavorMovieSerializer, UserFavorMovieDetailSerializer, \
    UserFavorActorDetailSerializer, UserFavorActorSerializer
from rest_framework.permissions import IsAuthenticated
from utils.permissions import IsOwnerOrReadOnly
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.authentication import SessionAuthentication


class UserFavorMovieViewSet(viewsets.GenericViewSet, mixins.RetrieveModelMixin, mixins.ListModelMixin, mixins.CreateModelMixin, mixins.DestroyModelMixin):
    """
    用户收藏
    """
    # permission是用来做权限判断的
    # IsAuthenticated：必须登录用户；IsOwnerOrReadOnly：必须是当前登录的用户
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
    # auth使用来做用户认证的
    authentication_classes = (JSONWebTokenAuthentication, SessionAuthentication)
    # 搜索的字段
    lookup_field = 'doubanId'

    # 动态选择serializer
    def get_serializer_class(self):
        if self.action == "list":
            return UserFavorMovieDetailSerializer
        elif self.action == "create":
            return UserFavorMovieSerializer
        return UserFavorMovieSerializer

    def get_queryset(self):
        # 只能查看当前登录用户的收藏，不会获取所有用户的收藏
        return UserFavorMovie.objects.filter(user=self.request.user)


class UserFavorActorViewSet(viewsets.GenericViewSet, mixins.RetrieveModelMixin,  mixins.ListModelMixin, mixins.CreateModelMixin, mixins.DestroyModelMixin):
    """
    用户收藏
    """
    # permission是用来做权限判断的
    # IsAuthenticated：必须登录用户；IsOwnerOrReadOnly：必须是当前登录的用户
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
    # auth使用来做用户认证的
    authentication_classes = (JSONWebTokenAuthentication, SessionAuthentication)
    # 搜索的字段
    lookup_field = 'actorId'

    # 动态选择serializer
    def get_serializer_class(self):
        if self.action == "list":
            return UserFavorActorDetailSerializer
        elif self.action == "create":
            return UserFavorActorSerializer
        return UserFavorActorSerializer

    def get_queryset(self):
        # 只能查看当前登录用户的收藏，不会获取所有用户的收藏
        return UserFavorActor.objects.filter(user=self.request.user)
