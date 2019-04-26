from django.db import models
from django.contrib.auth import get_user_model
User = get_user_model()


# Create your models here.
class Recommendation(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="用户")
    doubanId = models.CharField("豆瓣id", max_length=20, null=False, blank=False)
    description = models.CharField("推荐解释", max_length=255, null=False, blank=False)

    class Meta:
        verbose_name = "系统推荐"
        verbose_name_plural = verbose_name
        unique_together = ("user", "doubanId")

    def __str__(self):
        return self.user.username
