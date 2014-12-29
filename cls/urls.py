from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'cls.views.home', name='home'),
    url(r'^play/', include('play.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
