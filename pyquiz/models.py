from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Questions(models.Model):
    id = models.AutoField(primary_key=True)
    question = models.TextField()
    week_id = models.PositiveIntegerField()

class Choices(models.Model):
    question_id = models.ForeignKey('Questions')
    choice_1 = models.TextField()
    choice_2 = models.TextField()
    choice_3 = models.TextField(null = True)
    choice_4 = models.TextField(null = True)
    answer = models.CharField(max_length=255)

class QuizHistory(models.Model):
    """
    Maps the user's auth_user id to the last attended quiz id
    """
    user_id = models.ForeignKey(User)
    week_id = models.PositiveIntegerField()

