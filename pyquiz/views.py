import re
import base64
import json

from django.shortcuts import render,HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.core.mail import EmailMultiAlternatives, send_mail, get_connection
from django.utils.html import strip_tags
from django.template.loader import render_to_string
from django.db.models import Max, Count, Sum
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import user_passes_test

#cutom imports
from python_quizzup import settings
from pyquiz.models import Questions, Choices, LeaderBoard, QuizHistory, CustomUser as User, UserAnswers, UserBadges, Badges
from pyquiz import utils

def home(request):
    context = {}
    return render(request,'pyquiz/home.html', context)

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
        context['other_weeks'] = []
        quiz_id_history = [ quiz.week_id for quiz in QuizHistory.objects.filter(user_id=request.user.id)]
        for quiz_id in xrange(2,latest_week['week_id']):
            if quiz_id not in quiz_id_history:
                context['other_weeks'].append(quiz_id)
        badges = Badges.objects.all()
        user_badges_obj = UserBadges.objects.filter(user_id=request.user.id)
        user_badges = [ item.badge_id for item in user_badges_obj ]
        context['user_badges_count'] = len(user_badges_obj)
        context['badges'] = {}
        for badge in badges:
            context['badges'][badge.badge_id] = {'badge_details':badge}
            if badge in user_badges:
                context['badges'][badge.badge_id]['unlocked'] = True
    #    context['week_id'] = '' #TO TEST THE NO ACTIVE QUIZ LOGIC
    return render(request,'pyquiz/index.html', context)

@login_required
def quiz(request, week_id):
    print week_id
    if request.method == "GET":
        last_seen_quiz = QuizHistory.objects.filter(user_id = request.user.id, week_id=week_id)
        if last_seen_quiz:
            return render(request, 'pyquiz/404.html', {})
    latest_week = Questions.objects.all().values('week_id').order_by('-week_id')[0]
    print latest_week
#    if not (last_quiz and week_id != last_quiz[0].week_id+1): #TEST INVALID WEEKID LOGIC
    if request.method == "GET":
        quiz_obj =  QuizHistory(user_id=request.user, week_id=week_id).save()
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
            if not re.match('(csrfmiddlewaretoken)|(t_(\d+))|(question_(\d+))|(timeout_(\d+))', field):
#                print value,Choices.objects.get(question_id = field).answer
#                print value == Choices.objects.get(question_id = field).answer
                user_answer_obj = UserAnswers(user_id=request.user, question=request.POST['question_' + field], user_answer=value, week_id=week_id)
                if value == Choices.objects.get(question_id = field).answer:
                    user_answer_obj.is_correct = True
                    print score
                    score += 15 + min(int(request.POST['t_' + field]), 10)*1.5
                    print score
                else:
                    user_answer_obj.is_correct = False
                user_answer_obj.save()
        LeaderBoard(user_id = request.user, week_id = week_id, points = score).save()
        badge_id = None
        if score>=100 and score<200:
            badge_id = 6
        elif score>=200 and score<250:
            badge_id = 7
        elif score>=250:
            badge_id = 8
        if badge_id:
                user_badges_obj = UserBadges.objects.filter(user_id=request.user.id)
                user_badges = [ item.badge_id for item in user_badges_obj ]
                if badge_id not in user_badges:
                    UserBadges(user_id=request.user, badge_id=Badges.objects.get(badge_id=badge_id)).save()
        return HttpResponseRedirect(reverse('leaderboard', args=('/weekly/' + week_id,)))

def login_user(request):
    context = {'error':{}}
    if request.method == 'POST':
        print request.POST
        user = authenticate(email=request.POST.get('username'), password=request.POST.get('password'))
        print user
        if user is not None:
            # the password verified for the user
            if user.is_active:
                print("User is valid, active and authenticated")
                login(request, user)
                return HttpResponseRedirect(request.GET.get('next',reverse('index')) + '#whats-new-modal')
            else:
                print("The password is valid, but the account has been disabled!")
                context['error']['general'] = 'The password is valid, but the account has been disabled!'
        else:
            # the authentication system was unable to verify the username and password
            print("The username and password were incorrect.")
            context['error']['general'] = 'The username and password were incorrect.'
    return render(request,'pyquiz/login.html',context)
def get_leaderboard_stats():
    last_quiz = LeaderBoard.objects.all().aggregate(Max('week_id'))
    context = {}
    leaderboard = {}
    if last_quiz['week_id__max']:
        leaderboard_old = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard where week_id<%s group by user_id_id order by points desc', [last_quiz['week_id__max']])
        leaderboard_new = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard group by user_id_id order by points desc')
        if leaderboard_old:
            if leaderboard_new:
                leaderboard_old_map = {item.user_id:{'points':item.points,'rank':rank+1} for rank, item in enumerate(leaderboard_old)}
                len_leaderboard_old_map = len(list(leaderboard_new))
                for rank,item in enumerate(leaderboard_new):
                    if not leaderboard.get(item.user_id):
                        leaderboard[item.user_id] = {'username':item.user_id.email,'points':item.points,'rank':rank + 1,'previous_rank':leaderboard_old_map.get(item.user_id,{'rank':len_leaderboard_old_map})['rank'], 'first_name':item.user_id.first_name, 'last_name':item.user_id.last_name}
                        leaderboard[item.user_id]['rank_diff'] = leaderboard[item.user_id]['previous_rank'] - leaderboard[item.user_id]['rank']
            else:
                context['hide_status'] = True
                leaderboard_objs = leaderboard_old
                leaderboard = {item.user_id:{'username':item.user_id.email,'points':item.points,'rank':rank+1, 'first_name':item.user_id.first_name, 'last_name':item.user_id.last_name} for rank, item in enumerate(leaderboard_objs)}
        else:
            context['hide_status'] = True
            leaderboard_objs = leaderboard_new
            leaderboard = {item.user_id:{'username':item.user_id.email,'points':item.points,'rank':rank+1, 'first_name':item.user_id.first_name, 'last_name':item.user_id.last_name} for rank, item in enumerate(leaderboard_objs)}
    return context, leaderboard

@login_required
def show_leaderboard(request, board_type='overall', week_id=1):
    context = {}
    leaderboard = {}
    limit = int(request.GET.get('limit',0))
    if board_type and board_type.lower() == 'weekly' and week_id:
        leaderboard_objs = LeaderBoard.objects.filter(week_id = week_id).order_by('-points')
        if limit:
            leaderboard_objs = leaderboard_objs[:limit]
        leaderboard = {item.user_id:{'username':item.user_id.email,'points':item.points,'rank':rank+1, 'first_name':item.user_id.first_name, 'last_name':item.user_id.last_name} for rank, item in enumerate(leaderboard_objs)}
        context['weekly'] = True
        context['hide_status'] = True
    elif board_type and board_type.lower() == 'monthly':
        #leaderboard_objs = LeaderBoard.objects.all().values('user_id').annotate(points=Sum('points')).order_by('-points')
        leaderboard_objs = LeaderBoard.objects.raw('select id,user_id_id,sum(points) as points from (select * from pyquiz_leaderboard  order by week_id ) b group by user_id_id order by points desc')
        if limit:
            leaderboard_objs = list(leaderboard_objs)[:limit]
        leaderboard = {item.user_id:{'username':item.user_id.email,'points':item.points,'rank':rank+1, 'first_name':item.user_id.first_name, 'last_name':item
.user_id.last_name} for rank, item in enumerate(leaderboard_objs)}
        context['weekly'] = True
        context['hide_status'] = True
    else:
        if limit:
            leaderboard_objs = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard group by user_id_id order by points desc')
            leaderboard_objs = list(leaderboard_objs)[:limit]
            leaderboard = {item.user_id:{'username':item.user_id.email,'points':item.points,'rank':rank+1, 'first_name':item.user_id.first_name, 'last_name':item.user_id.last_name} for rank, item in enumerate(leaderboard_objs)}
            context['weekly'] = True
            context['hide_status'] = True
        else:
            extra_context, leaderboard = get_leaderboard_stats()
            context.update(extra_context)
    context['leaderboard'] = leaderboard
    print context
    print leaderboard
    if request.is_ajax():
        leaderboard_json = {}
        for key,value in context['leaderboard'].iteritems():
            value['points'] = int(value['points'])
            leaderboard_json[value['rank']] = value
        context['leaderboard'] = leaderboard_json
        return HttpResponse(json.dumps(context),mimetype="application/javascript")
    return render(request, 'pyquiz/leaderboard.html', context)

def register(request):
    context = {'error':{}}
    if request.method == "POST":
        print request.POST
        context['post_data'] = request.POST
        if User.objects.filter(email=request.POST['username']).exists():
            context['error']['username'] = 'Username Already taken :(' 
        else:
            new_user = User.objects.create_user(request.POST['username'].split("@")[0], request.POST['username'], request.POST['password'], \
                                                first_name=request.POST['first_name'], last_name=request.POST['last_name'], role=request.POST['role'])
            new_user.is_active = 0
            utils.send_mail_via_gmail('pyquiz/register-mail.html', {'domain':settings.DOMAIN, 'email_id':base64.b64encode(request.POST['username'])},\
                                    'PyQuiz:Welcome Aboard!', [request.POST['username']] \
                                )
            context['success'] = True
    print context
    return render(request,'pyquiz/register.html',context)

@login_required
def edit_profile(request):
    context = {}
    if request.method == "POST":
        print request.POST
        context['post_data'] = request.POST
        user_obj = User.objects.get(id=request.user.id)
        user_obj.first_name = request.POST['first_name']
        user_obj.last_name = request.POST['last_name']
        user_obj.confirm_password = request.POST['confirm_password']
        user_obj.role = request.POST['role']
        user_obj.save()
        context['success'] = True
        context['post_data'] = user_obj.__dict__
    else:
        context['post_data'] = User.objects.get(id=request.user.id)
    print context
    return render(request,'pyquiz/edit-profile.html',context)
def verify_password(request, email_id):
    context = {}
    email_id = base64.b64decode(email_id)
    u = User.objects.get(email__exact=email_id)
    u.is_active = 1
    u.save()
    return render(request,'pyquiz/verified.html',context)

def reset_password(request, email_id):
    context = {}
    if request.method == "POST":
        print request.POST
        email_id = base64.b64decode(email_id)
        print email_id
        u = User.objects.get(email__exact=email_id) 
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
        context['mail_sent'] = True
    return render(request,'pyquiz/forgot-password.html',context)
@login_required
def show_summary(request):
    context = {}
    template = 'pyquiz/summary.html'
    last_quiz = LeaderBoard.objects.all().aggregate(Max('week_id'))
    if last_quiz['week_id__max']:
        context['quiz_answers'] = UserAnswers.objects.filter(user_id=request.user.id, week_id=last_quiz['week_id__max']) 
    else:
        template = 'pyquiz/404.html'
    print context
    return render(request, template, context)

def admin_manager(request):
    context = {'data':{}}
    if not request.user.is_superuser:
        return render(request, 'pyquiz/404.html', {})
    if request.method == "POST":
        print request.POST
        question_obj = Questions(question=request.POST['question'], week_id=request.POST['week_id'], timeout=request.POST['timeout'])
        question_obj.save()
        choices_obj = Choices(question_id=question_obj, answer=request.POST[request.POST['answer']])
        for choice in ('choice_1', 'choice_2', 'choice_3', 'choice_4'):
            choices_obj.__setattr__(choice, request.POST.get(choice, None))
        choices_obj.save()
        return HttpResponseRedirect(reverse('admin'))
    else:
        last_quiz = QuizHistory.objects.all().aggregate(Max('week_id'))
        if last_quiz['week_id__max']:
            context['data']['week_id'] = last_quiz['week_id__max'] + 1
        else:
            context['data']['week_id'] = 1
#            context['question_number'] = Questions.objects.filter(week_id = context['week_id']).annotate(max_question_id=Count('id')) \
#                                            TO TEST THE NO WEEK_ID PRESENT IN QUESTIONS MODEL CASE
        context['data']['question_number'] = Questions.objects.filter(week_id = context['data']['week_id']).count()
        context['data']['question_number'] = context['data']['question_number'] + 1 if context['data']['question_number'] else 1
    print context
    return render(request,'pyquiz/admin.html',context)

@user_passes_test(lambda u: u.is_superuser)
@login_required
def generate_list(request):
    users_list = User.objects.all()
    email_ids = ''
#    email_ids = ','.join([user.email for user in users_list])
    for user in users_list:
        utils.send_mail_via_gmail('pyquiz/users-list-mail.html', {},\
                                    'PyQuiz:Users List', [user.email] \
                                )
    return HttpResponse("Mail Sent")
@user_passes_test(lambda u: u.is_superuser)
@login_required
def update_rewards(request):
    badges = { badge.badge_id:badge for badge in Badges.objects.all()}

    #BADGE 1
    overall_winners = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard group by user_id_id order by points desc limit 5')
    for item in overall_winners:
        user_badges_obj = UserBadges.objects.filter(user_id=item.user_id_id)
        user_badges = [ item.badge_id for item in user_badges_obj ]
        if badges[1] not in user_badges:
            UserBadges(user_id=item.user_id, badge_id=badges[1]).save()

    #BADGE 2
    last_quiz = LeaderBoard.objects.all().aggregate(Max('week_id'))
    weekly_winner = LeaderBoard.objects.filter(week_id = last_quiz['week_id__max']).order_by('-points')[0]
    user_badges_obj = UserBadges.objects.filter(user_id=weekly_winner.user_id)
    user_badges = [ item.badge_id for item in user_badges_obj ]
    if badges[2] not in user_badges:
        UserBadges(user_id=weekly_winner.user_id, badge_id=badges[2]).save()

    #BADGE 3
    monthly_winner = LeaderBoard.objects.raw('select id,user_id_id,sum(points) as points from (select * from pyquiz_leaderboard  order by week_id ) b group by user_id_id order by points desc limit 1')[0]
    user_badges_obj = UserBadges.objects.filter(user_id=monthly_winner.user_id_id)
    user_badges = [ item.badge_id for item in user_badges_obj ]
    if badges[3] not in user_badges:
        UserBadges(user_id=monthly_winner.user_id, badge_id=badges[3]).save()

    #BADGE 4
    overall_winner = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard group by user_id_id order by points desc limit 1')[0]
    user_badges_obj = UserBadges.objects.filter(user_id=overall_winner.user_id_id)
    user_badges = [ item.badge_id for item in user_badges_obj ]
    if badges[4] not in user_badges:
        UserBadges(user_id=overall_winner.user_id, badge_id=badges[4]).save()
    #BADGE 5
    if badges[5] not in user_badges:
        overall_second_winner = LeaderBoard.objects.raw('select id,user_id_id,SUM(points) as points from pyquiz_leaderboard group by user_id_id order by points desc limit 1, 1')[0]
        if overall_winner.points - overall_second_winner.points >50:
            UserBadges(user_id=overall_winner.user_id, badge_id=badges[5]).save()
    return HttpResponse("Rewards updated")

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
