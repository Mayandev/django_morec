#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019-04-19 17:34
# @Author  : Mayandev
# @Site    : https://github.com/Mayandev/
# @File    : adminx.py
# @Software: PyCharm

import xadmin
from xadmin import views


class BaseSetting(object):
    #添加主题功能
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(object):
    #全局配置，后台管理标题和页脚
    site_title = "MoRec 电影推荐系统后台"
    site_footer = "https://github.com/Mayandev/"

    #菜单收缩
    menu_style = "accordion"


class VerifyCodeAdmin(object):
    list_display = ['code', 'mobile', "add_time"]


xadmin.site.register(views.BaseAdminView, BaseSetting)
xadmin.site.register(views.CommAdminView, GlobalSettings)