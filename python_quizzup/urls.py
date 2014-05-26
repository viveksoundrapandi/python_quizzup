from django.conf.urls import patterns, include, url, handler404
from django.views.generic import TemplateView
from django.contrib import admin

admin.autodiscover()
handler404 = 'pyquiz.views.page_not_found'
handler500 = 'pyquiz.views.internal_error'
urlpatterns = patterns('',
    # Examples:
    #url(r'^(.*)$', TemplateView.as_view(template_name='maintainenance.html'), name="maintainenance"),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^pyquiz/', include("pyquiz.urls")),
    url(r'^/?$', 'pyquiz.views.home', name='home'),
    url(r'^gen_list/?$', 'pyquiz.views.generate_list', name='users'),
)
