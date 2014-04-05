from django.conf.urls import patterns, include, url
from pyquiz import views
urlpatterns = patterns('',
    url(r'^/?$', views.index, name='index'),
    url(r'^quiz/(?P<week_id>\d+)/?$', views.quiz, name='quiz'),
)


