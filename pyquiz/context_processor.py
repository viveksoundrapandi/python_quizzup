#from django.contrib.auth.models import User
from django.db.models import Max
from pyquiz.models import Questions, CustomUser as User
def get_user_details(user):
    user_details = {'user_profile':{}}
    user_details['user_profile'].update(User.objects.filter(id=user.id)[0].__dict__)
    return user_details
def add_extra_context(request):
    context = {}
    latest_week = Questions.objects.all().aggregate(Max('week_id'))
    if latest_week['week_id__max']:
        context['last_week_id'] = latest_week['week_id__max']
    if request.user.is_authenticated():
        context.update(get_user_details(request.user))
    return context 
