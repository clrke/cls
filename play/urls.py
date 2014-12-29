from django.conf.urls import patterns, url
from . import views

urlpatterns = patterns('',
	url(r'^$', views.home),
	url(r'^user$', views.user),
	url(r'^guest$', views.guest),
)
