from pyquiz.models import CustomUser
from django.http import HttpResponse

from allauth.exceptions import ImmediateHttpResponse
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter

from django.dispatch import receiver
from allauth.socialaccount.signals import pre_social_login
from allauth.account.utils import user_email, user_username, user_field

#@receiver(pre_social_login)
class MyAdapter(DefaultSocialAccountAdapter):
    def pre_social_login(self, request, sociallogin):
        # This isn't tested, but should work
        try:
                email = user_email(sociallogin.account.user)
                user = CustomUser.objects.get(email=email)
                if user and not sociallogin.is_existing:
                    sociallogin.connect(request, user)
                    return user
        except CustomUser.DoesNotExist:
            pass
