from django.conf.urls import patterns, include, url, handler404

from django.contrib import admin
admin.autodiscover()
handler404 = 'pyquiz.views.page_not_found'
handler500 = 'pyquiz.views.internal_error'
urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'python_quizzup.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^pyquiz/', include("pyquiz.urls")),
    url(r'^/?$', 'pyquiz.views.home', name='home'),
)
