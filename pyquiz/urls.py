from django.conf.urls import patterns, include, url
from pyquiz import views

urlpatterns = patterns('',
    url(r'^/?$', views.index, name='index'),
    url(r'^quiz/(?P<week_id>\d+)/?$', views.quiz, name='quiz'),
    url(r'^login/?$', views.login_user, name='login'),
    url(r'^logout/?$', views.logout_user, name='logout'),
    url(r'^leaderboard/?(?P<board_type>(weekly|overall))?/?(?P<week_id>\d+)?/?$', views.show_leaderboard, name='leaderboard'),
    url(r'^edit-profile/?$', views.edit_profile, name='edit-profile'),
    url(r'^register/?$', views.index, name='register'),
    url(r'^forgot-password/?$', views.forgot_password, name='forgot-password'),
    url(r'^reset/(?P<email_id>(.*))/?$', views.reset_password, name='reset-password'),

)


