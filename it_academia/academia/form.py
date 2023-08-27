from django import forms
from .models import User, Course, Assignment, Submission, Grade
from django.contrib.auth import password_validation
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

# This form is the UserCreationForm and
# was copied from the django auth forms.py file
# Just added the role and the phone_number field under the Meta


class UserForm(forms.ModelForm):
    """
    A form that creates a user, with no privileges, from the given username and
    password.
    """

    error_messages = {
        "password_mismatch": _("The two password fields didn’t match."),
    }
    password1 = forms.CharField(
        label=_("Mot de passe"),
        strip=False,
        widget=forms.PasswordInput(attrs={"autocomplete": "new-password"}),
        help_text=password_validation.password_validators_help_text_html(),
    )
    password2 = forms.CharField(
        label=_("Confirmation du mot de passe"),
        widget=forms.PasswordInput(attrs={"autocomplete": "new-password"}),
        strip=False,
        help_text=_("Enter the same password as before, for verification."),
    )

    class Meta:
        MONTHS = {1: _("Janvier"), 2: _("Fevrier"), 3: _("Mars"), 4: _("Avril"), 5: _("Mai"), 6: _(
            "Juin"), 7: _("Juillet"), 8: _("Août"), 9: _("Septembre"), 10: _("Octobre"), 11: _("Novembre"), 12: _("Décembre"), }
        model = User
        fields = ['username', 'first_name',
                  'last_name', 'role', 'birth_date', 'phone_number']
        widgets = {
            'birth_date': forms.SelectDateWidget(months=MONTHS, years=range(1920, 2023)),
        }

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise ValidationError(
                self.error_messages["password_mismatch"],
                code="password_mismatch",
            )
        return password2

    def _post_clean(self):
        super()._post_clean()
        # Validate the password after self.instance is updated with form data
        # by super().
        password = self.cleaned_data.get("password2")
        if password:
            try:
                password_validation.validate_password(password, self.instance)
            except ValidationError as error:
                self.add_error("password2", error)

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user


class CourseForm(forms.ModelForm):
    name = forms.CharField(label="Nom du cours")

    def __init__(self, *args, **kwargs):
        super(CourseForm, self).__init__(*args, **kwargs)
        self.fields['teacher'] = forms.ModelChoiceField(
            queryset=User.objects.filter(role="TEACHER"), widget=forms.Select, label="Chargé du cours", required=True)

    class Meta:
        model = Course
        fields = ['name', 'teacher']


class StudentsToEnrollForm(forms.Form):

    def __init__(self, course_id, *args, **kwargs):
        super(StudentsToEnrollForm, self).__init__(*args, **kwargs)
        self.fields['to_enroll'] = forms.ModelMultipleChoiceField(
            queryset=User.objects.filter(
                role="STUDENT").exclude(courses_took=course_id),
            widget=forms.CheckboxSelectMultiple,
            label="Etudiants à enroler",
            required=True
        )


class AssignmentForm(forms.ModelForm):
    class Meta:
        model = Assignment
        fields = ['course', 'title', 'file',
                  'description', 'due_date', 'status']
        widgets = {
            'course': forms.HiddenInput,
            'file': forms.FileInput,
            'due_date': forms.DateTimeInput
        }


class GradeForm(forms.ModelForm):
    class Meta:
        model = Grade
        fields = ['note', 'comment']
