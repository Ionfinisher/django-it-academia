# Generated by Django 4.2.3 on 2023-08-23 09:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('academia', '0008_alter_assignment_file'),
    ]

    operations = [
        migrations.AlterField(
            model_name='assignment',
            name='due_date',
            field=models.DateTimeField(),
        ),
    ]
