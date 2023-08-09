from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
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
        pass
    return render(request, "academia/noRole.html")
