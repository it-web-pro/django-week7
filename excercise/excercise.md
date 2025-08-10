# WEEK 7 EXCERCISE

![Execer7-4](./images/ER.svg)

1. สร้าง project ชื่อ `kmitl`

2. สร้าง database ใหม่ชื่อ `kmitl`

3. ให้ทำการ startapp ชื่อ `registration`

4. ให้ copy code ข้างล่างไปใส่ที่ไฟล์ `registration/models.py`

```PYTHON
from django.db import models


class Faculty(models.Model):
    name = models.CharField(max_length=100, unique=True)
    code = models.CharField(max_length=10, unique=True)

    def __str__(self):
        return self.name


class Professor(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    faculty = models.ForeignKey(Faculty, on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class Course(models.Model):
    course_code = models.CharField(max_length=20, unique=True)
    course_name = models.CharField(max_length=200)
    credits = models.PositiveSmallIntegerField()

    def __str__(self):
        return f"{self.course_code} {self.course_name}"


class Section(models.Model):
    class DayOfWeek(models.TextChoices):
        MONDAY = "MON", "จันทร์"
        TUESDAY = "TUE", "อังคาร"
        WEDNESDAY = "WED", "พุธ"
        THURSDAY = "THU", "พฤหัสบดี"
        FRIDAY = "FRI", "ศุกร์"

    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    section_number = models.CharField(max_length=3)
    semester = models.CharField(max_length=10)
    professor = models.ForeignKey(
        Professor, on_delete=models.SET_NULL, null=True, blank=True
    )
    day_of_week = models.CharField(max_length=3, choices=DayOfWeek.choices)
    start_time = models.TimeField()
    end_time = models.TimeField()
    capacity = models.PositiveSmallIntegerField(default=60)

    def __str__(self):
        return f"{self.course.course_code} ({self.section_number}) - {self.semester})"
        
    def dayOfWeek(self):
        weekday = {"MON": 0, "TUE": 1, "WED": 2, "THU": 3, "FRI": 4}
        return weekday[self.day_of_week]


class Student(models.Model):
    student_id = models.CharField(max_length=10, unique=True)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    faculty = models.ForeignKey(Faculty, on_delete=models.PROTECT)
    # ความสัมพันธ์จะถูกย้ายมาอยู่ที่นี่
    enrolled_sections = models.ManyToManyField(Section, blank=True)

    def __str__(self):
        return f"{self.student_id} - {self.first_name}"


class StudentProfile(models.Model):
    student = models.OneToOneField(Student, on_delete=models.CASCADE, primary_key=True)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    address = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Profile of {self.student.first_name}"

```

5. ให้ทำการ makemigrations และ migrate

6. ให้นักศึกษา run ไฟล์ kmitl_db.sql เพื่อ Insert ข้อมูลลง database

7. ให้นักศึกษาลากโฟลเดอร์ `templates` และ `templatetags` ใน excercise ไปไว้ที่โฟลเดอร์ `registration` ขอโปรเจคนักศึกษา

```sh
templates/
    - index.hmtl
    - nav.html
    - professor.html
    - course.html
    - faculty.html
```

## 1. แสดงผลข้อมูลใน Template

> สำหรับแบบฝึกหัดนี้ให้สร้าง View แบบ "class-based view"

1.1 ให้นักศึกษาสร้าง View และกำหนด URL ให้แสดงข้อมูลของพนักงานทั้งหมดในฐานข้อมูลในไฟล์ index.html ตามภาพ (0.25 คะแนน)

![Execer7-1](./images/student.png)

1.2 ให้นักศึกษาสร้าง View และกำหนด URL ให้แสดงข้อมูลของตำแหน่งงาน และแสดงจำนวนของพนักงานในไฟล์ professor.html ตามภาพ (0.25 คะแนน)

![Execer7-2](./images/professor.png)

1.3 ให้นักศึกษาสร้าง View และกำหนด URL ให้แสดงข้อมูลโปรเจคทั้งหมดในไฟล์ course.html ตามภาพ (0.25 คะแนน)

![Execer7-3](./images/course.png)

1.4 ให้นักศึกษาสร้าง View และกำหนด URL ให้แสดงข้อมูลโปรเจคทั้งหมดในไฟล์ faculty.html ตามภาพ (0.25 คะแนน)

![Execer7-4](./images/faculty.png)

1.5 กำหนด PATH สำหรับ Navbar ของเว็บไซต์ในไฟล์ nav.html (0.25 คะแนน)

**Hint:** ใช้ template tag "url" [Ref](https://docs.djangoproject.com/en/5.0/ref/templates/builtins/#url)

```HTML
    <header>
        <nav>
            <!-- กำหนด path  -->
            <a href="/">Professor</a>
            <a href="/">Student</a>
            <a href="/">Faculty</a>
            <a href="/">Course</a>
        </nav>
    </header>
```

1.5 ให้นักศึกษาเขียนให้ Quick Search ในทุก ๆ หน้า

**Hint:** ใช้ request.GET.get("key_param") เพื่อให้สามารถดึงข้อมูล Param จาก URLs ได้

- หน้า Student: สามารถเลือก `Field` ที่จะ `Filter` ได้ โดยเมื่อ Input แล้วนำข้อมูลที่กรอกไปใช้ โดยขอแค่อยู่ภายใน `Field` ที่เลือก และไม่สนตัวเล็กและตัวใหญ่

  - Full Name (Default)

    ![Execer1-5-(student)Full Name](./images/pro5_student_full_name.png)

  - Email

    ![Execer1-5-(student)Email](./images/pro5_student_email.png)

  - Faculty

    ![Execer1-5-(student)Faculty](./images/pro5_student_faculty.png)

- หน้า Professor: สามารถเลือก `Field` ที่จะ `Filter` ได้ โดยเมื่อ Input แล้วนำข้อมูลที่กรอกไปใช้ โดยขอแค่อยู่ภายใน `Field` ที่เลือก และไม่สนตัวเล็กและตัวใหญ่

  - Full Name (Default)

    ![Execer1-5-(professor)Full Name](./images/pro5_professor_full_name.png)

  - Faculty

    ![Execer1-5-(professor)Faculty](./images/pro5_professor_faculty.png)

- หน้า Faculty: เมื่อ Input แล้วนำข้อมูลที่กรอกไปใช้ `Filter` ชื่อ ขอแค่ข้อมูลอยู่ภายใน และไม่สนตัวเล็กตัวใหญ่

    ![Execer1-5-(faculty)](./images/pro5_faculty.png)

- หน้า Course: เมื่อ Input แล้วนำข้อมูลที่กรอกไปใช้ `Filter` ชื่อ ขอแค่ข้อมูลอยู่ภายใน และไม่สนตัวเล็กตัวใหญ่

    ![Execer1-5-(course)](./images/pro5_course.png)

## 2. เพิ่ม-ลบ-แก้ไข ข้อมูล

2.1. จากหน้า Student ให้นักศึกษาเพิ่มปุ่มสำหรับเพิ่มข้อมูลนักศึกษาดังรูปโดยมันจะต้องกดแล้วไปที่ url สำหรับสร้างข้อมูล จากนั้นทำการเพิ่ม View โดยกำหนดให้ใช้ Method `POST` และใช้ไฟล์ create_student.html (แก้ไข url ในไฟล์ให้ถูกต้อง)
- ปุ่ม create student
![Execer7-4](./images/pro5_student_create_btn.png)
- หน้าสร้างข้อมูลนักศึกษา
![Execer7-4](./images/pro5_student_create_page.png)

2.2 จากข้อ 1.1 ให้นักศึกษาแก้ไขโค้ดดังนี้ในไฟล์ index.html จากนั้นทำการเพิ่ม View สำหรับลบข้อมูลโดยต้องใช้ method delete

```html
<tr>
    <th class="px-4 py-3">Student ID</th>
    <th class="px-4 py-3">Full Name</th>
    <th class="px-4 py-3">Email</th>
    <th class="px-4 py-3">Phone nuber</th>
    <th class="px-4 py-3">Faculty</th>
    <th class="px-4 py-3">Registration Section</th>
    <th class="px-4 py-3 text-right">Actions</th>
</tr>

...

<tr class="hover:bg-orange-50 transition">
    <td class="px-4 py-3">{{ }}</td>
    <td class="px-4 py-3 font-medium">{{ }} {{ }}</td>
    <td class="px-4 py-3">{{ }}</td>
    <td class="px-4 py-3">{{ }}</td>
    <td class="px-4 py-3">{{ }}</td>
    <td class="px-4 py-3">
        {% if student.enrolled_sections.count %}
        {% for section in student.enrolled_sections.all|sortSectionByDayOfWeek|dictsort:'day_of_week_num' %}
            {{ }}
            ({{ }}) - {{ }}
            {{ }}-{{ }}<br />
        {% endfor %}
        {% else %}
        -
        {% endif %}
    </td>
    <td>
        <button onclick="deleteStudent({{  }})"
                class="px-3 py-1 rounded bg-red-500 text-white hover:bg-red-600">
            Delete
        </button>
    </td>
</tr>
```

จากนั้นเพิ่ม script
``` html
<script>
async function deleteStudent(studentId) {
  if (!confirm('ยืนยันลบนักศึกษา?')) return;

  const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

  const res = await fetch(`/registration/student/${studentId}/delete/`, {
    method: 'DELETE',
    headers: {
      'X-CSRFToken': csrftoken
    }
  });

  if (res) {
    window.location.reload();
  } else {
    alert('ลบไม่สำเร็จ');
  }
}
</script>
```

2.3 ให้นักศึกษาเพิ่ม View สำหรับแก้ไขข้อมูลโดยต้องเพิ่มปุ่ม edit เข้าไปเหมือนปุ่ม delete โดยแก้ไขโค้ดที่ index.html ดังนี้

```html
<td>
    <a href="/registration/student/{{  }}/edit/" class="px-3 py-1 rounded bg-orange-500 text-white hover:bg-orange-600">
        Edit
    </a>
    <button onclick="deleteStudent({{  }})"
            class="px-3 py-1 rounded bg-red-500 text-white hover:bg-red-600">
        Delete
    </button>
</td>
```
จากนั้นให้ใช้ไฟล์ edit_student.html ในการแก้ไขข้อมูล

**Hint:** ใน View ให้ใช้ json.loads(request.body) เพราะในไฟล์ edit_student.html ฟังก์ชัน handleUpdate มีการแนบ payload ไปเป็น json

## Demo

https://youtu.be/xIr_FoIuOks
