# Writing Views

[Django Document](https://docs.djangoproject.com/en/5.0/topics/http/views/)

> A view function, or view for short, is a Python function that takes a web request and returns a web response. 

โดยที่ response นั้นอาจจะเป็น HTML page หรือ redirect หรือ 404 error หรือ XML file หรือ รูปภาพ ... จริงๆ แล้วก็คืออะไรก็ได้

โดยปกติเราจะวาง View Function ไว้ใน views.py (แต่จริงๆ วางตรงไหนก็ได้ เรากำหนดการเข้าถึงที่ `urls.py`)

## A simple view - function-based views

```python
from django.http import HttpResponse
import datetime


def current_datetime(request):
    now = datetime.datetime.now()
    html = "<html><body>It is now %s.</body></html>" % now
    return HttpResponse(html)
```

*Important! อย่าลืมว่าเราจะเรียก view นี้ได้จะต้องไป map URL มาที่ view นี้ก่อนนะครับใน urls.py*

## Returning errors

โดยปกติเมื่อเรา return HttpResponse() Django จะ default HTTP status code = 200 ให้ แต่ถ้าเราต้องการกำหนด status code เองก็สามารถทำได้

```python
from django.http import HttpResponse


def my_view(request):
    # ...

    # Return a "created" (201) response code.
    return HttpResponse(content={
        "message": "Created successfully"
    }, status=201)

def my_view2(request):
    # ...

    # Return a "created" (201) response code.
    return HttpResponse(content={
        "message": "Item not found"
    }, status=404)

def my_view3(request):
    # ...

    # Return a "created" (201) response code.
    return HttpResponse(content={
        "code": "Validation Error",
        "field": "username",
        "error": "This field is required"
    }, status=400)
```

## The Http404 exception

เพื่อความง่าย Django มีหน้า page 404 standard มาให้ (แต่เราสามารถ custom เองได้นะ) โดยถ้าคุณมีการ raise Http404 ตรงไหนใน view ก็ตาม Django จะ catch error นี้ให้และ return page 404 ตัว standard มาให้เสมอ พร้อม HTTP status code = 404

```python
from django.http import Http404
from django.shortcuts import render
from polls.models import Poll


def detail(request, poll_id):
    try:
        p = Poll.objects.get(pk=poll_id)
    except Poll.DoesNotExist:
        raise Http404("Poll does not exist")
    return render(request, "polls/detail.html", {"poll": p})
```


## Django shortcut functions

[Doc](https://docs.djangoproject.com/en/5.2/topics/http/shortcuts/)

แพ็คเกจ `django.shortcuts` มี functions และ classes ที่มีประโยชน์สำหรับการเขียน views หลายตัว ตัวที่ใช้บ่อยๆ ได้แก่

### render()

```
render(request, template_name, context=None, content_type=None, status=None, using=None)
```

**Required arguments**

- request: request object
- template_name: ชื่อไฟล์ template

**Optional arguments**

- context: ค่าสำหรับส่งไป render ที่ไฟล์ template โดยจะต้องส่งเป็น dictionary
- content_type: [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types/Common_types) (default คือ `text/html`)
- status: status code สำหรับ response (default คือ `200`)

```python
from django.shortcuts import render

def my_view(request):
    # View code here...
    return render(
        request,
        "myapp/index.html",
        context={
            "foo": "bar",
        },
        content_type="application/xhtml+xml",
    )
```

### redirect()

```
redirect(to, *args, permanent=False, preserve_request=False, **kwargs)
```

Function นี้จะ return HttpResponseRedirect และทำการ redirect ไปยัง URL ที่ระบุ

**Required arguments**

- to: redirect to URL

**Optional arguments**

- permanent: 
    - ถ้าค่าเป็น True => permanent redirect (301) 
    - ถ้าค่าเป็น False => temporary redirect (302)
- preserve_request: 
    - ถ้าค่าเป็น True => บอกให้ browser ทำการ preserver method และ body เมื่อทำการ redirect 
    - ถ้าค่าเป็น False => บอกให้ browser ไม่ต้อง preserve

```python
# Passing the name of a view and optionally some positional or keyword arguments
def my_view(request):
    ...
    return redirect("some-view-name", foo="bar")

# Passing a hardcoded URL to redirect to
def my_view(request):
    ...
    return redirect("/some/url/")

# This also works with full URLs:
def my_view(request):
    ...
    return redirect("https://example.com/")
```

### get_object_or_404()

```
get_object_or_404(klass, *args, **kwargs)
```

**Arguments**

- klass: ชื่อ Model class ที่ต้องการ get object
- **kwargs: Q objects สำหรับ filter ข้อมูล

```python
from django.shortcuts import get_object_or_404


def my_view(request):
    obj = get_object_or_404(MyModel, pk=1)
```

ซึ่งเหมือนกันกับ code ด้านล่าง

```python
from django.http import Http404


def my_view(request):
    try:
        obj = MyModel.objects.get(pk=1)
    except MyModel.DoesNotExist:
        raise Http404("No MyModel matches the given query.")
```
