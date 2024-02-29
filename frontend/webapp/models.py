from django.db import models
from ckeditor.fields import RichTextField


class Post(models.Model):
    title = models.CharField(max_length=200, unique=True)
    sub_title = models.CharField(max_length=200, null=True)
    slug = models.SlugField(max_length=200, unique=True)
    updated_on = models.DateTimeField(auto_now=True)
    content = RichTextField()
    created_on = models.DateTimeField(auto_now_add=True)
    header_image = models.ImageField(upload_to="images/")

    class Meta:
        ordering = ['-created_on']

    def __str__(self):
        return self.title
