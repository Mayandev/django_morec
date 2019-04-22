"""morec URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import xadmin
from django.urls import path, include, re_path

from users.views import UserViewSet
from movie.views import MovieViewSet, GenreViewSet
from user_operation.views import UserFavorMovieViewset, UserFavorActorViewset

from rest_framework.documentation import include_docs_urls
from rest_framework.routers import SimpleRouter
from rest_framework.authtoken import views
from rest_framework_jwt.views import obtain_jwt_token

router = SimpleRouter()

router.register(r'movie', MovieViewSet, base_name='movie')
router.register(r'user', UserViewSet, base_name='user')
router.register(r'genre', GenreViewSet, base_name='genre')
router.register(r'user_favor_movie', UserFavorMovieViewset, base_name='user_favor_movie')
router.register(r'user_favor_actor', UserFavorActorViewset, base_name='user_favor_movie')

urlpatterns = [
    path('admin/', xadmin.site.urls),
    # drf文档，title自定义
    path('docs/', include_docs_urls(title='MoRec 服务器 Api 文档')),
    path('api-auth/',include('rest_framework.urls')),
    path('api-token-auth/', views.obtain_auth_token),
    path('login/', obtain_jwt_token),
    re_path('^', include(router.urls))
]
