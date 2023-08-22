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
    path('users_by_course/', views.getUsersByCourse, name='users_by_course'),
    path('create_user/', views.createUser, name='create_user'),
    path('update_user/<int:id>', views.updateUser, name='update_user'),
    path('update_user_record/<int:id>',
         views.updateUserRecord, name='update_user_record'),
    path('delete_user/<int:user_id>', views.deleteUser, name='delete_user'),
    path('courses/', views.getCourses, name='courses'),
    path('create_course/', views.createCourse, name='create_course'),
    path('update_course/<int:course_id>',
         views.updateCourse, name='update_course'),
    path('delete_course/<int:course_id>',
         views.deleteCourse, name='delete_course'),
    path('enroll_student/<int:course_id>',
         views.enrollStudent, name='enroll_student'),
    path('tester/', views.testing, name='testing'),
]

urlpatterns += staticfiles_urlpatterns()
