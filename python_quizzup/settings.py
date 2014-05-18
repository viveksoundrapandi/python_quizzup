"""
Django settings for python_quizzup project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))
import django.conf.global_settings as DEFAULT_SETTINGS


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = ')xo#6zl=i$q4)vxlq1-v(ny(@9igwli74_2qsppjf!39i-8(pz'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
ADMINS = (('pyquiz', 'pyquizcom@gmail.com'), ('vivek.s', 'vivek.s@global-analytics.com'))
SERVER_EMAIL = 'django@pyquiz.com'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'pyquizcom@gmail.com'
EMAIL_HOST_PASSWORD = 'pyqui_Z!23'
EMAIL_PORT = 587
EMAIL_USE_TLS = True

TEMPLATE_DEBUG = False

ALLOWED_HOSTS = ['localhost', '*']


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
    'allauth.socialaccount.providers.github',
    'allauth.socialaccount.providers.linkedin_oauth2',
    'allauth.socialaccount.providers.twitter',
    'allauth.socialaccount.providers.facebook',
    'south',
    'southut',
    'pyquiz',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'python_quizzup.urls'

WSGI_APPLICATION = 'python_quizzup.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'quizzup',
        'USER': 'root',                      # Not used with sqlite3.
        'PASSWORD': '',                  # Not used with sqlite3.
        'HOST': 'localhost',          
    }
}

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_URL = '/static/'
STATICFILES_DIRS = ( 
    BASE_DIR + "/static/",
)
TEMPLATE_DIRS = (
    BASE_DIR+'/templates',
)
LOGIN_URL = '/pyquiz/login/'
LOGIN_REDIRECT_URL = '/pyquiz/'
TEMPLATE_CONTEXT_PROCESSORS = DEFAULT_SETTINGS.TEMPLATE_CONTEXT_PROCESSORS + (
    "django.core.context_processors.request",
    "allauth.account.context_processors.account",
    "allauth.socialaccount.context_processors.socialaccount",
    'pyquiz.context_processor.add_extra_context',
)
AUTHENTICATION_BACKENDS  = DEFAULT_SETTINGS.AUTHENTICATION_BACKENDS + (
    # `allauth` specific authentication methods, such as login by e-mail
    "django.contrib.auth.backends.ModelBackend",
    "allauth.account.auth_backends.AuthenticationBackend",
)
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
DOMAIN = 'http://localhost:8000'
AUTH_USER_MODEL = 'pyquiz.CustomUser'
SITE_ID = 1
#ACCOUNT_EMAIL_REQUIRED = True
USERNAME_REQUIRED = False
ACCOUNT_EMAIL_VERIFICATION  = "none"
SOCIALACCOUNT_ADAPTER = 'pyquiz.social_adapter.MyAdapter'
#ACCOUNT_AUTHENTICATION_METHOD  = "email"
#ACCOUNT_USER_MODEL_EMAIL_FIELD = "email"
#ACCOUNT_USER_MODEL_USERNAME_FIELD = True
#ACCOUNT_UNIQUE_EMAIL  = True
#SOCIALACCOUNT_QUERY_EMAIL  = True
SOCIALACCOUNT_AUTO_SIGNUP = True
SOCIALACCOUNT_PROVIDERS = \
    { 'google':
        { 'SCOPE': ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email' ],
          'AUTH_PARAMS': { 'access_type': 'online' } },
      'linkedin':
        {'SCOPE': ['r_emailaddress'],
       'PROFILE_FIELDS': ['id',
                         'first-name',
                         'last-name',
                         'email-address',
                         'picture-url',
                         'public-profile-url']},
    'facebook':
       {'SCOPE': ['email',],
        'AUTH_PARAMS': {'auth_type': 'reauthenticate'},
        'METHOD': 'oauth2',
        'LOCALE_FUNC': 'path.to.callable',
        'VERIFIED_EMAIL': False}
    }
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'handlers': {
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': '/tmp/debug.log',
            'formatter': 'verbose'
        },
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler',
            'include_html': True
        }
    },
    'loggers': {
        'django': {
            'handlers': ['file'],
            'propagate': True,
            'level': 'DEBUG',
        },
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': False,
        },
        'pyquiz': {
            'handlers': ['file'],
            'level': 'DEBUG',
        }
    }
}    
