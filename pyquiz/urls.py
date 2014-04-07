from django.conf.urls import patterns, include, url
from pyquiz import views

urlpatterns = patterns('',
    url(r'^/?$', views.index, name='index'),
    url(r'^quiz/(?P<week_id>\d+)/?$', views.quiz, name='quiz'),
    url(r'^login/?$', views.login_user, name='login'),
    url(r'^logout/?$', views.logout_user, name='logout'),
    url(r'^leaderboard/?(?P<board_type>(weekly|overall))?/?(?P<week_id>\d+)?/?$', views.show_leaderboard, name='leaderboard'),
)


