import re

from django.shortcuts import render,HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout

#cutom imports
from python_quizzup import settings
from pyquiz.models import Questions, Choices, LeaderBoard
@login_required
def index(request):
    context = {}
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    print latest_week
    last_quiz = LeaderBoard.objects.filter(user_id = request.user.id).order_by('-week_id')
    print last_quiz
    context['week_id'] = latest_week['week_id'] if not last_quiz or last_quiz[0].week_id != latest_week['week_id'] else ''
#    context['week_id'] = '' #TO TEST THE NO ACTIVE QUIZ LOGIC
    return render(request,'pyquiz/index.html', context)

@login_required
def quiz(request, week_id):
    print week_id
    last_quiz = LeaderBoard.objects.filter(user_id = request.user.id).order_by('-week_id')
    print last_quiz
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    print latest_week
#    if not (last_quiz and week_id != last_quiz[0].week_id+1): #TEST INVALID WEEKID LOGIC
    if (last_quiz and week_id != last_quiz[0].week_id+1) or str(latest_week['week_id'])!=week_id:
        return render(request, 'pyquiz/404.html', {})
    if request.method == "GET":
        questions = Questions.objects.filter(week_id = int(week_id)).order_by('?')
        print questions
        questions_set = []
        for question in questions:
            question.question = question.question.replace('<code>','<div class="callout callout-info"><pre>').replace('</code>','</pre></div>')
            questions_set.append({'question':question, 'choices':Choices.objects.get(question_id = question.id)})
        print questions_set
        return render(request,'pyquiz/quiz.html',{'questions_set':questions_set})
    else:
        print request.POST
        score = 0
        for field, value in request.POST.items():
            if not re.match('(csrfmiddlewaretoken)|(t_(\d+))', field):
                if value == Choices.objects.get(question_id = field).answer:
                    score += 15 + min(int(request.POST['t_' + field]), 10)*1.5
        LeaderBoard(user_id = request.user, week_id = week_id, points = score).save()
        return HttpResponse(score)                
#        return HttpResponseRedirect("/pyquiz/leaderboard/weekly/")

def login_user(request):
    context = {'error':{}}
    if request.method == 'POST':
        print request.POST
        user = authenticate(username=request.POST.get('username'), password=request.POST.get('password'))
        print user
        if user is not None:
            # the password verified for the user
            if user.is_active:
                print("User is valid, active and authenticated")
                login(request, user)
                return HttpResponseRedirect(request.GET.get('next','/pyquiz/'))
            else:
                print("The password is valid, but the account has been disabled!")
        else:
            # the authentication system was unable to verify the username and password
            print("The username and password were incorrect.")
            context['error']['general'] = 'The username and password were incorrect.'
    return render(request,'pyquiz/login.html',context)

@login_required
def show_leaderboard(request, board_type='overall', week_id=None):
    context = {}
    leaderboard = LeaderBoard.objects.filter(user_id = request.user.id)
    if board_type and board_type.lower() == 'weekly' and week_id:
        leaderboard = leaderboard.filter(week_id = week_id)
        context['weekly'] = True
    if leaderboard:
        context['leaderboard'] = leaderboard.order_by('-points')
    print leaderboard
    print leaderboard[0].user_id.username
    return render(request, 'pyquiz/leaderboard.html', context)

def logout_user(request):
    logout(request)
    return HttpResponseRedirect(settings.LOGIN_URL)
def page_not_found(request):
    template = 'pyquiz/404_static.html'
    if request.user.is_authenticated():
        template = 'pyquiz/404.html'
    return render(request, template, {})
def internal_error(request):
    return render(request, 'pyquiz/500.html', {})
