from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.shortcuts import redirect

def home(request):
	return redirect('play.views.home')

urlpatterns = patterns('',
    # Examples:
    url(r'^$', home, name='home'),
    url(r'^play/', include('play.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
