from django.urls import path

from .views import PostQuestionView

urlpatterns = [
    path("post_question/", PostQuestionView.as_view(), name="post_question"),
]