from pyquiz.models import Questions
def add_extra_context(request):
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    return {'last_week_id':latest_week['week_id']}
