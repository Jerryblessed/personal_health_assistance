from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.urls import reverse
import os
from django.db import models

# Create your models here.

class Food(models.Model):
	FoodId    = models.AutoField(primary_key=True)
	FoodName  = models.CharField(max_length=30)
	FoodCat   = models.CharField(max_length=30)
	FoodPrice = models.FloatField(max_length=15)
	FoodImage = models.ImageField(upload_to='media',default='')
	class Meta:
		db_table = "FP_Food"
		
class Cust(models.Model):
	CustId    = models.AutoField(primary_key=True)
	CustFName  = models.CharField(max_length=30)
	CustLName  = models.CharField(max_length=30)
	CustCont  = models.CharField(max_length=10)
	CustEmail = models.CharField(max_length=50)
	CustPass  = models.CharField(max_length=60)
	Address  = models.CharField(max_length=150,default='')
	class Meta:
		db_table = "FP_Cust"
		
class Admin(models.Model):
	AdminId   = models.CharField(primary_key=True,max_length=20)
	AdminPass = models.CharField(max_length=60)
	class Meta:
		db_table = "FP_Admin"
		
class Cart(models.Model):
	CartId    = models.AutoField(primary_key=True)
	CustEmail = models.CharField(max_length=50)
	FoodId    = models.CharField(max_length=50)
	FoodQuant = models.CharField(max_length=10)
	class Meta:
		db_table = "FP_Cart"
		
class Order(models.Model):
	OrderId   = models.AutoField(primary_key=True)
	CustEmail = models.CharField(max_length=30)
	OrderDate = models.CharField(max_length=40)
	TotalBill = models.FloatField(max_length=50)
	class Meta:
		db_table = "FP_Order"


class Post(models.Model):
	title = models.CharField(max_length=100)
	file = models.FileField(null=True,blank=True,upload_to='Files')
	content = models.TextField()
	date_posted = models.DateTimeField(default=timezone.now)
	author = models.ForeignKey(User, on_delete=models.CASCADE)

	def __str__(self):
		return self.title

	def extension(self):
		name, extension = os.path.splitext(self.file.name)
		return extension

	def get_absolute_url(self):
		return reverse('post-detail', kwargs={'pk': self.pk})

        
