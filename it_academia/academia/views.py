from django.contrib.auth.decorators import login_required
from academia.form import *
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.shortcuts import get_object_or_404, render, redirect
from django.db.models import Q


@login_required
def home(request):
    user = request.user
    if user.role == 'STUDENT':
        return render(request, "registration/home.html")
    elif user.role == 'TEACHER':
        pass
    elif user.role == 'ADMIN':
        students = User.objects.filter(role="STUDENT")
        teachers = User.objects.filter(role="TEACHER")
        if request.method == 'POST':
            search_term = request.POST.get('search_term')
            if search_term:
                students = students.filter(Q(first_name__icontains=search_term) | Q(
                    last_name__icontains=search_term))
                teachers = teachers.filter(Q(first_name__icontains=search_term) | Q(
                    last_name__icontains=search_term))

        return render(request, "admin/dashboard.html", {'students': students, 'teachers': teachers})
    return render(request, "academia/403_error_page.html")


@login_required
def getUsersByCourse(request):
    user = request.user
    if user.role == 'ADMIN':
        if request.method == 'POST':
            selected_course_id = request.POST.get('course')
            if selected_course_id:
                selected_course = Course.objects.get(pk=selected_course_id)
                all_users = selected_course.enrolled_students.all()
        else:
            all_users = User.objects.filter(
                role="STUDENT", courses_took__isnull=False).distinct()

        courses = Course.objects.all()
        return render(request, "admin/user/users_by_course.html", {'all_users': all_users, 'courses': courses})

    return render(request, "academia/403_error_page.html")


@login_required
def createUser(request):
    user = request.user
    if user.role == 'ADMIN':
        if request.method == 'POST':
            form = UserForm(request.POST)
            if form.is_valid():
                form.save()
                # Redirect to a success page
                return redirect('home')
        else:
            form = UserForm()

        return render(request, "admin/user/create_user.html", {'form': form})

    return render(request, "academia/403_error_page.html")


@login_required
def updateUser(request, id):
    user = request.user
    if user.role == 'ADMIN':
        userObject = User.objects.get(id=id)
        form = UserForm(instance=userObject)
        return render(request, "admin/user/update_user.html", {'form': form})

    return render(request, "academia/403_error_page.html")


def updateUserRecord(request, id):
    userObject1 = User.objects.get(id=id)
    userObject1.first_name = request.POST['first_name']
    userObject1.last_name = request.POST['last_name']
    userObject1.role = request.POST['role']
    userObject1.phone_number = request.POST['phone_number']
    userObject1.save()

    return HttpResponseRedirect(reverse('home'))


def deleteUser(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    if request.method == 'POST':
        user.delete()
        return redirect('home')
    return render(request, 'admin/user/delete_user.html')


@login_required
def getCourses(request):
    user = request.user
    if user.role == 'ADMIN':
        all_courses = Course.objects.all()
        return render(request, "admin/course/courses.html", {'all_courses': all_courses})
    return render(request, "academia/403_error_page.html")


@login_required
def createCourse(request):
    user = request.user
    if user.role == 'ADMIN':
        if request.method == 'POST':
            form = CourseForm(request.POST)
            if form.is_valid():
                form.save()
                return redirect('home')
        else:
            form = CourseForm()

        return render(request, "admin/course/create_course.html", {'form': form})

    return render(request, "academia/403_error_page.html")


@login_required
def updateCourse(request, course_id):
    user = request.user
    if user.role == 'ADMIN':
        course = get_object_or_404(Course, pk=course_id)
        if request.method == 'POST':
            form = CourseForm(request.POST, instance=course)
            if form.is_valid():
                form.save()
                return redirect('courses')
        else:
            form = CourseForm(instance=course)

        return render(request, "admin/course/update_course.html", {'form': form})

    return render(request, "academia/403_error_page.html")


def deleteCourse(request, course_id):
    course = get_object_or_404(Course, pk=course_id)
    if request.method == 'POST':
        course.delete()
        return redirect('home')
    return render(request, 'admin/course/delete_course.html')


@login_required
def enrollStudent(request, course_id):
    user = request.user
    if user.role == 'ADMIN':
        if request.method == 'POST':
            form = StudentsToEnrollForm(data=request.POST, course_id=course_id)
            if form.is_valid():
                selected_students = form.cleaned_data['to_enroll']
                course = Course.objects.get(pk=course_id)
                course.enrolled_students.add(*selected_students)
                # the * is to pass the students as single elements
                return HttpResponseRedirect(reverse('courses'))
        else:
            form = StudentsToEnrollForm(course_id=course_id)
            return render(request, "admin/course/enroll_student.html", {'form': form, 'course_id': course_id})

    return render(request, "academia/403_error_page.html")


def testing(request):
    form = StudentsToEnrollForm()

    return render(request, "admin/testFor.html", {'form': form})
