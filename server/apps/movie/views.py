from django.shortcuts import render

# Create your views here.


from movie.serializers import MovieSerializer, GenreSerializer
from .models import Movie, Genre
from rest_framework import mixins, viewsets
from rest_framework.pagination import PageNumberPagination


class MoviePagination(PageNumberPagination):
    '''
    商品列表自定义分页
    '''

    # 默认每页显示的个数
    page_size = 10
    # 可以动态改变每页显示的个数
    page_size_query_param = 'page_size'
    # 页码参数
    page_query_param = 'page'
    # 最多能显示多少页
    max_page_size = 100


class MovieViewSet(mixins.ListModelMixin,
                    mixins.RetrieveModelMixin,
                    mixins.UpdateModelMixin,
                    mixins.DestroyModelMixin,
                    mixins.CreateModelMixin,
                    viewsets.GenericViewSet):
    """
    电影列表
    """
    pagination_class = MoviePagination
    queryset = Movie.objects.all().order_by('id')
    serializer_class = MovieSerializer


class GenreViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    queryset = Genre.objects.all().order_by('id')
    serializer_class = GenreSerializer

