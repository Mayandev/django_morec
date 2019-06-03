# :clapper: Morec - 电影推荐应用

这是一个非常精美的电影推荐应用，使用 Flutter 与 Django 进行构建。浏览基本电影信息的同时，还可根据用户收藏的电影、演员、标签，定时生成推荐列表以及相应的推荐解释。

项目在这个 [Repo](https://github.com/Mayandev/morec) 的基础上进行了完善，新增了如下功能：

- [x] 登陆注册
- [x] 标签选择
- [x] 电影收藏
- [x] 演员收藏
- [x] 猜你喜欢


## Setup

### 1. Clone the repo

```bash
$ git clone https://github.com/Mayandev/django_morec.git
$ cd django_morec
```

### 2. Running

```bash
# start server
$ python manage.py runserver
# run flutter
$ flutter run
```

如果你对服务器端不感兴趣，这里单独创建了一个 Repo，App 可以独立于服务器运行，你可以[点击链接](https://github.com/Mayandev/morec)访问这个项目。


## Frontend

前端使用 Flutter 进行构建，兼容 Android 与 iOS 两端。使用简白设计，部分 UI 仿自[豆瓣 App](https://www.douban.com/doubanapp/frodo?channel=nimingye)，icon 图标来自[阿里图标库](https://www.iconfont.cn/)。

使用到的插件有：

|                             插件                             |      用途      |
| :----------------------------------------------------------: | :------------: |
| [carousel_slider](https://pub.dartlang.org/packages/carousel_slider) |  首页 banner   |
|         [dio](https://pub.dartlang.org/packages/dio)         |    网络请求    |
| [flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin) |  打开 webview  |
|       [share](https://pub.dartlang.org/packages/share)       |    分享链接    |
| [palette_generator](https://pub.dartlang.org/packages/palette_generator) | 获取图片主色调 |
|  [photo_view](https://pub.dartlang.org/packages/photo_view)  |    图片预览    |
|      [chewie](https://pub.dartlang.org/packages/chewie)      | 预告片视频播放 |


### App 截图

![screenshot for App](https://github.com/Mayandev/django_morec/blob/master/screenshot/app.png)

[点击链接](https://github.com/Mayandev/morec)可以查看更多截图。

## Server

服务器使用 Django + restframework 框架搭建，数据库使用 MySQL，配置 xadmin 生成管理系统后台，并使用 crontab 生成系统定时任务进行定时推荐。

使用到的插件：

|                            插件                            |                用途                 |
| :--------------------------------------------------------: | :---------------------------------: |
|  [restframework](https://www.django-rest-framework.org/)   | restful 风格 API，自动生成 API 文档 |
|        [xadmin](https://github.com/sshwsfc/xadmin)         |      生成更高级的后台管理系统       |
| [django_crontab](https://pypi.org/project/django-crontab/) |  django 定时任务，用于定时生成推荐  |

### server 截图

**后台管理系统：**

![screenshot for server](https://github.com/Mayandev/django_morec/blob/master/screenshot/server_1.png)

**API 文档：**

![screenshot for server](https://github.com/Mayandev/django_morec/blob/master/screenshot/server_2.png)

## Dataset

推荐功能是基于 item 的协同过滤推荐，[数据集](https://sites.google.com/site/erhengzhong/datasets)来自 [Erheng Zhong](https://sites.google.com/site/erhengzhong/home) 博士 为在 KDD'12, TKDD'14, SDM'12 上发表论文而收集的数据，其中包含 5 万多部电影（3 万多有电影名称，2 万多没有电影名称），2.8 万 用户，280 万条评分数据。

## End

这个项目是我的本科毕业设计，如果你喜欢这个项目，欢迎给我一个 star，也算是对我的一份鼓励与认可。

欢迎在 [Github 主页](https://github.com/Mayandev)关注我的其他项目。

如果对这个项目有任何建议或意见，欢迎在 [Issues](https://github.com/Mayandev/django_morec/issues) 提出。

欢迎关注我的公众号，不定期分享资源和干货！

![](https://raw.githubusercontent.com/Mayandev/mayandev_blog_image/master/images%E6%9C%AA%E6%A0%87%E9%A2%98-1.png)



