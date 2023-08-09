from django.conf.urls import include
from django.urls import path
from academia import views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.contrib.auth import views as auth_views


urlpatterns = [
    # path("", views.home, name="home"),
    # path("hello/<name>", views.hello_there, name="hello_there"),
    path("", views.home, name="home"),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('home/', views.home, name='home'),
    path('tester/', views.testing, name='testing'),
]

urlpatterns += staticfiles_urlpatterns()
