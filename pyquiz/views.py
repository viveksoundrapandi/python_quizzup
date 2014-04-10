import re
import base64

from django.shortcuts import render,HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.core.mail import EmailMultiAlternatives, send_mail, get_connection
from django.utils.html import strip_tags
from django.template.loader import render_to_string
from django.db.models import Max
from django.contrib.auth.models import User

#cutom imports
from python_quizzup import settings
from pyquiz.models import Questions, Choices, LeaderBoard, UserDetails, QuizHistory
from pyquiz import utils
@login_required
def index(request):
    context = {}
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')
    if latest_week:
        latest_week = latest_week[0]
        print latest_week
        last_quiz = LeaderBoard.objects.filter(user_id = request.user.id).order_by('-week_id')
        print last_quiz
        context['week_id'] = latest_week['week_id'] if not last_quiz or last_quiz[0].week_id != latest_week['week_id'] else ''
    #    context['week_id'] = '' #TO TEST THE NO ACTIVE QUIZ LOGIC
    return render(request,'pyquiz/index.html', context)

@login_required
def quiz(request, week_id):
    print week_id
    if request.method == "GET":
        last_quiz = QuizHistory.objects.filter(user_id = request.user.id)
    else:
        last_quiz = LeaderBoard.objects.filter(user_id = request.user.id).order_by('-week_id')
    print last_quiz
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    print latest_week
#    if not (last_quiz and week_id != last_quiz[0].week_id+1): #TEST INVALID WEEKID LOGIC
    if (last_quiz and week_id != last_quiz[0].week_id+1) or str(latest_week['week_id'])!=week_id:
        return render(request, 'pyquiz/404.html', {})
    if request.method == "GET":
        QuizHistory(user_id=request.user, week_id=week_id).save()
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
        """
        leaderboard = LeaderBoard.objects.all().order_by('-points')
        if leaderboard:
            leaderboard_list = [item for item in leaderboard]
            sorted(leaderboard_list, key = lambda x:x.points, reverse=True) 
            for rank, item in enumerate(leaderboard_list):
                item.previous_rank = item.rank
                item.rank = rank
                item.save()
        """
        return HttpResponseRedirect("/pyquiz/leaderboard/weekly/")

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
                context['error']['general'] = 'The password is valid, but the account has been disabled!'
        else:
            # the authentication system was unable to verify the username and password
            print("The username and password were incorrect.")
            context['error']['general'] = 'The username and password were incorrect.'
    return render(request,'pyquiz/login.html',context)
@login_required
def show_leaderboard(request, board_type='overall', week_id=1):
    context = {}
    leaderboard = {}
    if board_type and board_type.lower() == 'weekly' and week_id:
        leaderboard_objs = LeaderBoard.objects.filter(week_id = week_id)
        leaderboard = {item.user_id:{'username':item.user_id.username,'points':item.points,'rank':rank+1} for rank, item in enumerate(leaderboard_objs)}
        context['weekly'] = True
        context['hide_status'] = True
    else:
        last_quiz = LeaderBoard.objects.all().aggregate(Max('week_id'))
        if last_quiz['week_id__max']:
            leaderboard_old = LeaderBoard.objects.filter(week_id__lt = last_quiz['week_id__max']).order_by('-points')
            leaderboard_new = LeaderBoard.objects.all().order_by('-points')        
            if leaderboard_old:
                leaderboard = {}
                if leaderboard_new:
                    leaderboard_old_map = {item.user_id:{'points':item.points,'rank':rank+1} for rank, item in enumerate(leaderboard_old)}
                    for rank,item in enumerate(leaderboard_new):
                        leaderboard[item.user_id] = {'username':item.user_id.username,'points':item.points,'rank':rank+1,'previous_rank':leaderboard_old_map.get(item.user_id,{'rank':0})['rank']}
                else:
                    context['hide_status'] = True
                    leaderboard_objs = leaderboard_old
                    leaderboard = {item.user_id:{'username':item.user_id.username,'points':item.points,'rank':rank+1} for rank, item in enumerate(leaderboard_objs)}
            else:
                context['hide_status'] = True
                leaderboard_objs = leaderboard_new
                leaderboard = {item.user_id:{'username':item.user_id.username,'points':item.points,'rank':rank+1} for rank, item in enumerate(leaderboard_objs)}
    context['leaderboard'] = leaderboard
    print leaderboard
    return render(request, 'pyquiz/leaderboard.html', context)

def register(request):
    context = {'error':{}}
    if request.method == "POST":
        print request.POST
        context['post_data'] = request.POST
        if User.objects.filter(username=request.POST['username']).exists():
            context['error']['username'] = 'Username Already taken :(' 
        else:
            new_user = User.objects.create_user(request.POST['username'], request.POST['username'], request.POST['password'], \
                                                first_name=request.POST['first_name'], last_name=request.POST['last_name'])
            new_user.is_active = 0
            UserDetails(user_id=new_user, role=request.POST['role']).save()
            utils.send_mail_via_gmail('pyquiz/register-mail.html', {'domain':settings.DOMAIN, 'email_id':base64.b64encode(request.POST['username'])},\
                                    'PyQuiz:Welcome Aboard!', [request.POST['username']] \
                                )
            context['success'] = True
    print context
    return render(request,'pyquiz/register.html',context)

@login_required
def edit_profile(request):
    context = {}
    return render(request,'pyquiz/edit-profile.html',context)
def verify_password(request, email_id):
    context = {}
    email_id = base64.b64decode(email_id)
    u = User.objects.get(username__exact=email_id)
    u.is_active = 1
    u.save()
    return render(request,'pyquiz/verified.html',context)

def reset_password(request, email_id):
    context = {}
    if request.method == "POST":
        print request.POST
        email_id = base64.b64decode(email_id)
        print email_id
        u = User.objects.get(username__exact=email_id) 
        u.set_password(request.POST['password'])
        u.is_active = 1
        u.save()
        context['success'] = True
    return render(request,'pyquiz/reset-password.html',context)

def forgot_password(request):
    context = {}
    if request.method == "POST":
        print request.POST
        utils.send_mail_via_gmail('pyquiz/forgot-password-mail.html', {'domain':settings.DOMAIN, 'email_id':base64.b64encode(request.POST['username'])},\
                                    'PyQuiz:reset-password', [request.POST['username']] \
                                )
        """
        html_content = render_to_string('pyquiz/forgot-password-mail.html', {'domain':settings.DOMAIN, 'email_id':base64.b64encode(request.POST['username'])}) 
        text_content = strip_tags(html_content) # this strips the html, so people will have the text as well.
        msg = EmailMultiAlternatives('PyQuiz:reset-password', text_content, 'vivekhas3@gmail.com',[request.POST['username']])
        msg.attach_alternative(html_content, "text/html")
        connection = get_connection()
        connection.username='vivekhas3@gmail.com'
        connection.password='g00gle_vivek'
        connection.send_messages([msg,])
        """
        context['mail_sent'] = True
    return render(request,'pyquiz/forgot-password.html',context)

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
