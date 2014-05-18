#from django.contrib.auth.models import User
from django.db.models import Max
from django.core.urlresolvers import resolve
from django.core.urlresolvers import Resolver404
from pyquiz.models import Questions, CustomUser as User
import config
def get_user_details(user):
    user_details = {'user_profile':{}}
    user_details['user_profile'].update(User.objects.filter(id=user.id)[0].__dict__)
    user_details['user_profile']['is_superuser'] = user.is_superuser
    return user_details
def add_extra_context(request):
    context = {}
    latest_week = Questions.objects.all().aggregate(Max('week_id'))
    if latest_week['week_id__max']:
        context['last_week_id'] = latest_week['week_id__max']
    if request.user.is_authenticated():
        context.update(get_user_details(request.user))
    try:
        context['current_url'] = resolve(request.path_info).url_name
        context['current_url_args'] = request.resolver_match.kwargs
    except Resolver404:
        context['current_url'] = ''
        context['current_url_args'] = '' 
    context['is_app'] = True if request.META['HTTP_USER_AGENT'] in config.ALLOWED_APP_USER_AGENTS else False
    #context['is_app'] = True
    return context 
