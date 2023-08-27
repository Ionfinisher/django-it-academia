from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    TEACHER = 'TEACHER'
    STUDENT = 'STUDENT'
    ADMIN = 'ADMIN'

    ROLE_CHOICES = (
        (TEACHER, 'Teacher'),
        (STUDENT, 'Student'),
        (ADMIN, 'Admin'),
    )
    role = models.CharField(
        max_length=30, choices=ROLE_CHOICES, verbose_name='Role')
    phone_number = models.CharField(max_length=20)
    birth_date = models.DateField()


class Course(models.Model):
    name = models.CharField(max_length=100)
    enrolled_students = models.ManyToManyField(
        User, related_name='courses_took')
    teacher = models.ForeignKey(
        User, related_name='courses_taught', null=True, on_delete=models.SET_NULL)


class Assignment(models.Model):
    ONGOING = 'EN COURS'
    SUBMITED = 'SOUMIS'
    GRADED = 'CORRIGÉ'
    course = models.ForeignKey(
        Course, on_delete=models.CASCADE, related_name='assignements')
    title = models.CharField(max_length=100)
    file = models.FileField(
        upload_to='academia/uploads/assignements/')
    description = models.TextField()
    due_date = models.DateTimeField()
    STATUS_CHOICES = (
        (ONGOING, 'En cours'),
        (SUBMITED, 'Soumis'),
        (GRADED, 'Corrigé'),
    )
    status = models.CharField(
        max_length=30, choices=STATUS_CHOICES, default=ONGOING, verbose_name='Status')


class Submission(models.Model):
    student = models.ForeignKey(User, on_delete=models.CASCADE)
    assignment = models.ForeignKey(Assignment, on_delete=models.CASCADE)
    file = models.FileField(upload_to='academia/uploads/submissions/')
    submitted_at = models.DateTimeField(auto_now_add=True)


class Grade(models.Model):
    submission = models.ForeignKey(Submission, on_delete=models.CASCADE)
    note = models.DecimalField(max_digits=5, decimal_places=2)
    comment = models.TextField()
