# Generated by Django 4.2 on 2023-05-28 22:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0011_alter_category_image_alter_chair_image_credit'),
    ]

    operations = [
        migrations.AlterField(
            model_name='category',
            name='image',
            field=models.ImageField(default='category-default.jpg', upload_to='category_images'),
        ),
        migrations.AlterField(
            model_name='chair',
            name='image',
            field=models.ImageField(default='chair-default.jpg', upload_to='chair_pics'),
        ),
    ]