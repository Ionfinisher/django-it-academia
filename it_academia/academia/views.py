from datetime import date
from datetime import datetime
import os
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
        courses_took = request.user.courses_took.all()
        assignements = Assignment.objects.filter(
            course__in=courses_took).order_by('due_date')
        return render(request, "registration/home.html", {
            'courses_took': courses_took,
            'assignements': assignements,
        })

    elif user.role == 'TEACHER':
        teacher = User.objects.get(pk=user.id)
        my_courses = teacher.courses_taught.all()

        return render(request, "teacher/dashboard.html", {'courses_taught': my_courses, 'teacher': teacher})

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


@login_required
def updateUserTeacher(request, id):
    user = request.user
    if user.role == 'TEACHER':
        userObject = User.objects.get(id=id)
        form = UserForm(instance=userObject)
        return render(request, "teacher/user/user_profile.html", {'form': form})

    return render(request, "academia/403_error_page.html")


@login_required
def updateUserStudent(request, id):
    user = request.user
    if user.role == 'STUDENT':
        userObject = User.objects.get(id=id)
        form = UserForm(instance=userObject)
        return render(request, "student/user/user_profile.html", {'form': form})

    return render(request, "academia/403_error_page.html")


def updateUserRecord(request, id):
    userObject1 = User.objects.get(id=id)
    userObject1.first_name = request.POST['first_name']
    userObject1.last_name = request.POST['last_name']
    if request.POST.get('role'):
        userObject1.role = request.POST['role']
    birth_year = int(request.POST['birth_date_year'])
    birth_month = int(request.POST['birth_date_month'])
    birth_day = int(request.POST['birth_date_day'])
    birth_date = date(birth_year, birth_month, birth_day)
    userObject1.birth_date = birth_date
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


@login_required
def courseDetails(request, id):
    user = request.user
    course = get_object_or_404(Course, id=id)
    assignements = course.assignements.all()
    if user.role == 'STUDENT':
        return render(request, 'student/course/course_detail.html', {'course': course, 'assignments': assignements})
    elif user.role == 'TEACHER':
        return render(request, 'teacher/course/course_detail.html', {'course': course, 'assignments': assignements})
    else:
        return render(request, "academia/403_error_page.html")


@login_required
def teacherEnrollStudent(request, course_id):
    user = request.user
    if user.role == 'TEACHER':
        if request.method == 'POST':
            form = StudentsToEnrollForm(data=request.POST, course_id=course_id)
            if form.is_valid():
                selected_students = form.cleaned_data['to_enroll']
                course = Course.objects.get(pk=course_id)
                course.enrolled_students.add(*selected_students)
                # the * is to pass the students as single elements
                return HttpResponseRedirect(reverse('home'))
        else:
            form = StudentsToEnrollForm(course_id=course_id)
            return render(request, "teacher/course/enroll_student.html", {'form': form, 'course_id': course_id})

    return render(request, "academia/403_error_page.html")


@login_required
def createAssignment(request, course_id):
    user = request.user
    if user.role == 'TEACHER':
        if request.method == 'POST':
            form = AssignmentForm(request.POST, request.FILES)
            if form.is_valid():
                form.save()
                return redirect('course_detail', id=course_id)
        else:
            form = AssignmentForm()

        return render(request, "teacher/assignement/create_assignement.html", {'form': form, 'course_id': course_id})

    return render(request, "academia/403_error_page.html")


@login_required
def assignementDetails(request, course_id, assignement_id):
    user = request.user
    course = get_object_or_404(Course, id=course_id)
    course_assignements = Assignment.objects.filter(
        course=course).order_by('id')
    assignement = get_object_or_404(Assignment, id=assignement_id)
    submissions = assignement.submission_set.all()
    prev_assignement = None
    for idx, assignment1 in enumerate(course_assignements):
        if assignment1 == assignement:
            if idx > 0:
                prev_assignement = course_assignements[idx - 1]
            break
    submission0 = Submission.objects.filter(
        student=request.user, assignment=assignement).first()

    if user.role == 'TEACHER':
        return render(request, 'teacher/assignement/assignement_detail.html', {'course': course, 'assignement': assignement, 'submissions': submissions})
    elif user.role == 'STUDENT':
        if submission0:
            file_name = os.path.basename(submission0.file.name)
            context = {'course': course,
                       'assignement': assignement,
                       'submission': submission0,
                       'file_name': file_name,
                       'course_assignements': course_assignements,
                       'prev_assignement': prev_assignement,
                       }
        else:
            context = {'course': course,
                       'assignement': assignement,
                       'submission': submission0,
                       'file_name': None,
                       'course_assignements': course_assignements,
                       'prev_assignement': prev_assignement,
                       }

        return render(request, 'student/assignement/assignement_detail.html', context)
    else:
        return render(request, "academia/403_error_page.html")


@login_required
def updateAssignement(request, course_id, assignement_id):
    user = request.user
    if user.role == 'TEACHER':
        assignement = get_object_or_404(Assignment, id=assignement_id)
        due_date = assignement.due_date.strftime('%Y-%m-%dT%H:%M')
        # Format to match datetime-local input
        if request.method == 'POST':
            form = AssignmentForm(
                request.POST, request.FILES, instance=assignement)
            if form.is_valid():
                form.save()
                return redirect('assignement_detail', assignement_id=assignement_id, course_id=course_id)
        else:
            form = AssignmentForm(instance=assignement)

        return render(request, "teacher/assignement/update_assignement.html", {'form': form, 'assignement': assignement, 'course_id': course_id, 'due_date': due_date})

    return render(request, "academia/403_error_page.html")


def submitAssignement(request, assignement_id):
    assignement = Assignment.objects.get(pk=assignement_id)

    submission = Submission.objects.create(
        student=request.user,
        assignment=assignement,
        file=request.FILES['file'],
        submitted_at=datetime.now()
    )
    submission.save()

    return redirect('course_detail', id=assignement.course.id)


def gradeSubmission(request, submission_id, course_id):
    submission = get_object_or_404(Submission, pk=submission_id)
    old_grade = Grade.objects.filter(submission=submission).first()
    if request.method == 'POST':
        form = GradeForm(request.POST)
        if form.is_valid():
            grade = form.save(commit=False)
            grade.submission = submission
            grade.save()
            return redirect('assignement_detail', course_id=course_id, assignement_id=submission.assignment.id)
    else:
        form = GradeForm()

    context = {
        'form': form,
        'submission': submission,
        'course_id': course_id,
        'old_grade': old_grade
    }
    return render(request, 'teacher/grade/grade_submission.html', context)


def myGrades(request):
    user = request.user
    grades = Grade.objects.filter(submission__student=user)

    context = {'user': user, 'grades': grades}
    return render(request, 'student/grades/my_grades.html', context)


def testing(request):
    form = StudentsToEnrollForm()

    return render(request, "admin/testFor.html", {'form': form})
