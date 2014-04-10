from django.contrib.auth.models import User
from pyquiz.models import Questions, UserDetails
def get_user_details(user):
    user_details = {'user_profile':{}}
    user_details['user_profile'].update(User.objects.filter(id=user.id)[0].__dict__)
    user_details['user_profile'].update(UserDetails.objects.filter(user_id=user)[0].__dict__)
    return user_details
def add_extra_context(request):
    context = {}
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    context['last_week_id'] = latest_week['week_id']
    context.update(get_user_details(request.user))
    return context 
