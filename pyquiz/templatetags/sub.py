from django import template

register = template.Library()
@register.filter    
def sub(value, arg):
    return int(value) - int(arg)
