from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User, AnonymousUser

def home(request):
	return render(request, 'play/index.html')

@login_required(login_url= '/admin/login/')
def user(request):
	return render(request, 'play/game.html', {'user':request.user})

def guest(request):
	return render(request, 'play/game.html', {'user':AnonymousUser()})
