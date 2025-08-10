from django import template

register = template.Library()

@register.filter
def sortSectionByDayOfWeek(sections):
    for section in sections:
        section.day_of_week_num = section.dayOfWeek()
    return sections