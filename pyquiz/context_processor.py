#from django.contrib.auth.models import User
from django.db.models import Max
from django.core.urlresolvers import resolve
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
    context['current_url'] = request.resolver_match.url_name
    context['current_url_args'] = request.resolver_match.kwargs
    context['is_app'] = True if request.META['HTTP_USER_AGENT'] in config.ALLOWED_APP_USER_AGENTS else False
    #context['is_app'] = True
    return context 
