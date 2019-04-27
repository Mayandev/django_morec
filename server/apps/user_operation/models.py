from django.db import models

# Create your models here.

from django.db import models

from django.contrib.auth import get_user_model

User = get_user_model()


class UserFavorMovie(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="用户")
    doubanId = models.CharField("豆瓣id", max_length=20, null=False, blank=False)
    title = models.CharField("标题", max_length=100, null=False, blank=False)
    poster = models.CharField("海报url", max_length=255, null=False, blank=False)

    class Meta:
        verbose_name = "用户收藏电影"
        verbose_name_plural = verbose_name
        unique_together = ("user", "doubanId")

    def __str__(self):
        return self.user.username


class UserFavorActor(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="用户")
    actorId = models.CharField("演员id", max_length=20, null=False, blank=False)
    name = models.CharField("演员姓名", max_length=100, null=False, blank=False)
    avatar = models.CharField("演员头像url", max_length=255, null=False, blank=False)
    works = models.CharField("相关作品", max_length=255, null=True, blank=True)

    class Meta:
        verbose_name = "用户收藏演员"
        verbose_name_plural = verbose_name
        unique_together = ("user", "actorId")

    def __str__(self):
        return self.user.username


class UserFavorGenre(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="用户")
    genre = models.CharField("种类", max_length=100, null=False, blank=False)

    class Meta:
        verbose_name = "用户收藏电影类型"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.user.username
