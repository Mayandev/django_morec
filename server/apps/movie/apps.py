from django.apps import AppConfig


class MovieConfig(AppConfig):
    name = 'movie'
    # app名字后台显示中文
    verbose_name = "电影管理"
