# Generated by Django 4.2.3 on 2023-08-19 23:06

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('academia', '0003_alter_course_teacher'),
    ]

    operations = [
        migrations.AlterField(
            model_name='course',
            name='enrolled_students',
            field=models.ManyToManyField(related_name='courses_took', to=settings.AUTH_USER_MODEL),
        ),
    ]