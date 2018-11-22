# Create your models here.
from __future__ import unicode_literals

from django.db import models
from django.urls import reverse

GENDER_CHOICES = (
    ('M', 'MALE'),
    ('F', 'FEMALE'),
    ('O', 'OTHER')
)


class Employee(models.Model):
    first_name = models.CharField(max_length=64)
    middle_initial = models.CharField(max_length=1)
    last_name = models.CharField(max_length=64)
    ssn = models.CharField(max_length=9)
    birth_date = models.DateField()
    address = models.CharField(max_length=100)
    sex = models.CharField(max_length=1, choices=GENDER_CHOICES)
    salary = models.DecimalField(max_digits=10, decimal_places=2)
    supervisor = models.ForeignKey('self', null=True, blank=True)
    department = models.ForeignKey('Department', related_name='employees')

    def __str__(self):
        return f"{self.first_name} {self.middle_initial}" \
               f"{self.last_name} {self.ssn}"

    def full_name(self):
        return f"{self.first_name} {self.middle_initial}" \
               f"{self.last_name}"

    def get_absolute_url(self):
        return reverse("employee_detail", kwargs={"pk": self.pk})

    class Meta:
        ordering = ['last_name', 'first_name', 'middle_initial']
