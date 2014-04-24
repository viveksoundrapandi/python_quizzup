from django import template
import urllib, hashlib

register = template.Library()
default = "mm"

@register.filter(name='fetch_gravatar')
def fetch_gravatar(email, size=45):
    """
    A custom template tag to hash the given email and generate the gravatar  URL. This resultant URL will either give the user's gravatar image or a default
    mystery man image.
    Args:
        @email: THe input user's email
        @size: the resolution at which the image needs to be rendered. This defaults to 45
    Returns:
        URL to the gravatar image
    Vars:
        @default: the default image to be returned from gravatar when the emailid doesn't exist in gravatar
    """
    gravatar_url = "http://www.gravatar.com/avatar/" + hashlib.md5(email.lower()).hexdigest() + "?"
    gravatar_url += urllib.urlencode({'d':default, 's':str(size)})
    return gravatar_url
