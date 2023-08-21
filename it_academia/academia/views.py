from django.contrib.auth.decorators import login_required
from academia.form import *
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.shortcuts import render, redirect


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
        return render(request, "admin/dashboard.html", {'students': students, 'teachers': teachers})
    return render(request, "academia/403_error_page.html")


@login_required
def getUsersByCourse(request):
    user = request.user
    if user.role == 'ADMIN':
        all_users = User.objects.all()
        return render(request, "admin/users_by_course.html", {'all_users': all_users})
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

        return render(request, "admin/create_user.html", {'form': form})

    return render(request, "academia/403_error_page.html")


@login_required
def updateUser(request, id):
    user = request.user
    if user.role == 'ADMIN':
        userObject = User.objects.get(id=id)
        form = UserForm(instance=userObject)
        return render(request, "admin/update_user.html", {'form': form})

    return render(request, "academia/403_error_page.html")


def updateUserRecord(request, id):
    userObject1 = User.objects.get(id=id)
    userObject1.first_name = request.POST['first_name']
    userObject1.last_name = request.POST['last_name']
    userObject1.role = request.POST['role']
    userObject1.phone_number = request.POST['phone_number']
    userObject1.save()

    return HttpResponseRedirect(reverse('home'))


@login_required
def getCourses(request):
    user = request.user
    if user.role == 'ADMIN':
        all_courses = Course.objects.all()
        return render(request, "admin/courses.html", {'all_courses': all_courses})
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

        return render(request, "admin/create_course.html", {'form': form})

    return render(request, "academia/403_error_page.html")


def testing(request):
    if request.method == 'POST':
        form = UserForm(request.POST)
        if form.is_valid():
            form.save()
            # user = User.objects.create_user("john", "lennon@thebeatles.com", "johnpassword")
            return redirect(request, 'home')  # Redirect to a success page
    else:
        form = UserForm()

    return render(request, "admin/testFor.html", {'form': form})
