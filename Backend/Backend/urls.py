from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from . import settings
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.views.decorators.csrf import csrf_exempt


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('authentication.urls')),
    path('', include('frontend.urls')),
    path('appointments/', include('appointments.urls')),
] + staticfiles_urlpatterns() +\
              static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)