from django.db import models

# Create your models here.
class Knight(models.Model):
    name = models.CharField(max_length=100, unique=True)
    of_the_round_table = models.BooleanField()
    dances_whenever_able = models.BooleanField(default=False)
    shrubberies = models.IntegerField(null=False)
