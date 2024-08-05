# Writing your first view

ก่อนจะไปสร้าง view เรามาทำการ setup project "week7_tutorial" และสร้าง app "blogs" กันก่อน
และทำการ copy models เหล่านี้ลงไปที่ `blogs/models.py`

```python
from django.db import models

class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField("date published")

    def __str__(self):
        return self.question_text


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        return self.choice_text
```

จากนั้นก็ `makemigrations` และ `migrate` และทำการ import `blogs.sql` เข้าไปใน database

## Let's start!

สำหรับ poll application เราสร้างจะ views ดังต่อไปนี้

- Question “index” page – แสดงรายการ questions ล่าสุด
- Question “detail” page – แสดง question text และฟอร์มสำหรับทำการโหวต
- Question “results” page – แสดงผลลัพธ์การโหวตของ question
- Vote action – สำหรับจัดการการโหวต

เรามาเริ่มต้นด้วยการเพิ่ม code ด้านล่างนี้ใน `/polls/views.py`

```python
from django.http import HttpResponse

def index(request):
    return HttpResponse("This is the index page of polls app")

def detail(request, question_id):
    return HttpResponse("You're looking at question %s." % question_id)


def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)


def vote(request, question_id):
    return HttpResponse("You're voting on question %s." % question_id)
```

กำหนด path url สำหรับเข้าถึง views ด้านบน `/polls/urls.py`

```python
from django.urls import path

from . import views

urlpatterns = [
    # ex: /polls/
    path("", views.index, name="index"),
    # ex: /polls/5/
    path("<int:question_id>/", views.detail, name="detail"),
    # ex: /polls/5/results/
    path("<int:question_id>/results/", views.results, name="results"),
    # ex: /polls/5/vote/
    path("<int:question_id>/vote/", views.vote, name="vote"),
]
```

หมายเหตุ: <int:question_id> เป็นการประกาศ path parameter ซึ่งจะรับค่าตัวแปรที่ถูกส่งมาใน url

## Write views that actually do something

เรามาปรับแก้ไข view index() ให้ทำการ query ข้อมูล question 5 รายการล่าสุด เรียงตาม pub_date แบบจากมากไปน้อย

```python
from django.http import HttpResponse
from django.shortcuts import render

from .models import Question


def index(request):
    latest_question_list = Question.objects.order_by("-pub_date")[:5]
    context = {"latest_question_list": latest_question_list}
    return render(request, "index.html", context)

# Leave the rest of the views (detail, results, vote) unchanged
```

ใน view index() เราได้ทำการ return list ของ questions ออกมา และส่งต่อข้อมูลไปยัง `/polls/index.html`

เอ้ะแต่ไฟล์ `/polls/index.html` มันอยู่ไหน ไม่เห็นมี @_@

เราจะต้องไปสร้างไฟล์ **template** ก่อน โดยสร้าง folder `/polls/templates` และสร้างไฟล์ `/polls/templates/index.html` และเพิ่ม code ด้านล่าง

```html
<html>
    <head>
    </head>
    <body>
        <h1>Lastest questions</h1>
        {% if latest_question_list %}
            <ul>
            {% for question in latest_question_list %}
                <li><a href="/polls/{{ question.id }}/">{{ question.question_text }}</a></li>
            {% endfor %}
            </ul>
        {% else %}
            <p>No polls are available.</p>
        {% endif %}
    </body>
</html>
```

แก้ไขไฟล์ `mysite/settings.py` เพิ่ม code ดังนี้

```python
import os
SETTINGS_PATH = os.path.dirname(os.path.dirname(__file__))

TEMPLATE_DIRS = (
    os.path.join(SETTINGS_PATH, 'templates'),
)
```

เรามาลอง start server ดูว่าหน้า index สามารถใช้งานได้ไหม

เปิด browser และพิมพ์ url `http://127.0.0.1:8000/polls/`
