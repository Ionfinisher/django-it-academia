from django.contrib.auth.decorators import login_required
from academia.form import *
from django.contrib.auth import login, authenticate, logout
from django.shortcuts import render, redirect


@login_required
def home(request):
    user = request.user
    if user.role == 'STUDENT':
        return render(request, "registration/home.html")
    elif user.role == 'TEACHER':
        pass
    elif user.role == 'ADMIN':
        return render(request, "admin/dashboard.html")
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
