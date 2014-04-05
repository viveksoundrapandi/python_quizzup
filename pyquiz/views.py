from django.shortcuts import render,HttpResponse
from pyquiz.models import Questions, Choices
# Create your views here.
def index(request):
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    print latest_week
    return render(request,"pyquiz/index.html",{'week_id':latest_week['week_id']})
def quiz(request, week_id):
    print week_id
    questions = Questions.objects.filter(week_id = int(week_id)).order_by('?')
    print questions
    return render(request,"pyquiz/quiz.html",{'questions':questions})
