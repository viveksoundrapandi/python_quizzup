from django.conf.urls import patterns, include, url
from pyquiz import views

urlpatterns = patterns('',
    url(r'^/?$', views.index, name='index'),
    url(r'^quiz/(?P<week_id>\d+)/?$', views.quiz, name='quiz'),
    url(r'^login/?$', views.login_user, name='login'),
    url(r'^logout/?$', views.logout_user, name='logout'),
    url(r'^leaderboard/?(?P<board_type>(weekly|overall|monthly))?/?(?P<week_id>\d+)?/?$', views.show_leaderboard, name='leaderboard'),
    url(r'^edit-profile/?$', views.edit_profile, name='edit-profile'),
    url(r'^register/?$', views.register, name='register'),
    url(r'^forgot-password/?$', views.forgot_password, name='forgot-password'),
    url(r'^reset/(?P<email_id>(.*))/?$', views.reset_password, name='reset-password'),
    url(r'^verify/(?P<email_id>(.*))/?$', views.verify_password, name='verify-password'),
    url(r'^summary/?$', views.show_summary, name='summary'),
    url(r'^review/(?P<week_id>\d+)/?$', views.show_review, name='review'),
    url(r'^feedback/?$', views.feedback, name='feedback'),
    url(r'^update-rewards/?$', views.update_rewards, name='rewards'),
    url(r'^admin/?$', views.admin_manager, name='admin'),
)


