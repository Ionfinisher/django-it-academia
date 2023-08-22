# Generated by Django 4.2.3 on 2023-08-22 11:28

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('academia', '0004_alter_course_enrolled_students'),
    ]

    operations = [
        migrations.AddField(
            model_name='assignment',
            name='status',
            field=models.CharField(choices=[('EN COURS', 'En cours'), ('SOUMIS', 'Soumis'), ('CORRIGÉ', 'Corrigé')], default='EN COURS', max_length=30, verbose_name='Status'),
        ),
        migrations.AddField(
            model_name='user',
            name='birth_date',
            field=models.DateField(default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]
