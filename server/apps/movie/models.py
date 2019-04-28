from django.db import models


# Create your models here.

class Movie(models.Model):
    movieId = models.CharField("数据集id", max_length=20, null=True, blank=True)
    doubanId = models.CharField("豆瓣id", max_length=20, null=True, blank=True)
    closest_movie = models.CharField("相似电影", max_length=256, null=True, blank=True)


    class Meta:
        verbose_name = "电影信息"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.doubanId


class Genre(models.Model):
    genre = models.CharField("电影类型", max_length=30, null=False, blank=False)
    doubanIds = models.CharField("相关电影", max_length=256, null=True, blank=True)

    class Meta:
        verbose_name = "电影类型"
        verbose_name_plural = verbose_name


class Actor(models.Model):
    name = models.CharField("演员名称", max_length=50, null=False, blank=False)

    class Meta:
        verbose_name = "演员",
        verbose_name_plural = verbose_name

