from rest_framework import viewsets
from rest_framework import mixins
from .models import Recommendation
from .serializers import RecommendationSerializer
from rest_framework.permissions import IsAuthenticated
from utils.permissions import IsOwnerOrReadOnly
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.authentication import SessionAuthentication
from rest_framework.pagination import PageNumberPagination


class RecommendationPagination(PageNumberPagination):
    '''
    商品列表自定义分页
    '''

    # 默认每页显示的个数
    page_size = 5
    # 可以动态改变每页显示的个数
    page_size_query_param = 'page_size'
    # 页码参数
    page_query_param = 'page'
    # 最多能显示多少页
    max_page_size = 100


class RecommendationViewSet(viewsets.GenericViewSet, mixins.ListModelMixin):
    """
    用户收藏
    """
    # permission是用来做权限判断的
    # IsAuthenticated：必须登录用户；IsOwnerOrReadOnly：必须是当前登录的用户
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
    # auth使用来做用户认证的
    authentication_classes = (JSONWebTokenAuthentication, SessionAuthentication)
    pagination_class = RecommendationPagination
    serializer_class = RecommendationSerializer

    def get_queryset(self):
        # 只能查看当前登录用户的推荐
        return Recommendation.objects.filter(user=self.request.user).order_by('random_rank')

