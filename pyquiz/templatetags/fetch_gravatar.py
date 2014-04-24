from django import template
import urllib, hashlib

register = template.Library()
size = 45
default = "mm"

@register.filter(name='fetch_gravatar')
def fetch_gravatar(email):
    """
    A custom template tag to hash the given email and generate the gravatar  URL. This resultant URL will either give the user's gravatar image or a default
    mystery man image.
    Args:
        @email: THe input user's email
    Returns:
        URL to the gravatar image
    Vars:
        @default: the default image to be returned from gravatar when the emailid doesn't exist in gravatar
        @size: the resolution at which the image needs to be rendered
    """
    gravatar_url = "http://www.gravatar.com/avatar/" + hashlib.md5(email.lower()).hexdigest() + "?"
    gravatar_url += urllib.urlencode({'d':default, 's':str(size)})
    return gravatar_url
