# Generated by Django 4.2 on 2023-06-09 15:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('classroom', '0007_article_lecture_mem_alter_category_options_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='course',
            old_name='category',
            new_name='table',
        ),
    ]