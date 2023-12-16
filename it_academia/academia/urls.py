from django.conf.urls import include
from django.urls import path
from academia import views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.contrib.auth import views as auth_views


urlpatterns = [
    path("", views.home, name="home"),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('home/', views.home, name='home'),
    path('users_by_course/', views.getUsersByCourse, name='users_by_course'),
    path('create_user/', views.createUser, name='create_user'),
    path('update_user/<int:id>', views.updateUser, name='update_user'),
    path('update_teacher/<int:id>', views.updateUserTeacher, name='update_teacher'),
    path('update_student/<int:id>', views.updateUserStudent, name='update_student'),
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
    path('course_detail/<int:id>', views.courseDetails, name='course_detail'),
    path('teacher_enroll_student/<int:course_id>',
         views.teacherEnrollStudent, name='teacher_enroll_student'),
    path('create_assignement/<int:course_id>',
         views.createAssignment, name='create_assignement'),
    path('assignement_detail/<int:course_id>/<int:assignement_id>',
         views.assignementDetails, name='assignement_detail'),
    path('update_assignement/<int:course_id>/<int:assignement_id>',
         views.updateAssignement, name='update_assignement'),
    path('submit_assignement/<int:assignement_id>/',
         views.submitAssignement, name='submit_assignement'),
    path('grade_submission/<int:submission_id>/<int:course_id>',
         views.gradeSubmission, name='grade_submission'),
    path('my_grades/', views.myGrades, name='my_grades'),

    path('tester/', views.testing, name='testing'),
]

urlpatterns += staticfiles_urlpatterns()
