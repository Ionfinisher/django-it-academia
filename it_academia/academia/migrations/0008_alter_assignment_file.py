# Generated by Django 4.2.3 on 2023-08-23 09:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('academia', '0007_alter_assignment_file'),
    ]

    operations = [
        migrations.AlterField(
            model_name='assignment',
            name='file',
            field=models.FileField(upload_to='it_academia/academia/uploads/assignements/'),
        ),
    ]