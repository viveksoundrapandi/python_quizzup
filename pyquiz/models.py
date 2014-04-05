from django.db import models

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
