# django-it-academia
A moodle-like django web app to manage submissions and evaluations of IT projects


## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)

## Installation
<a name="installation"></a>

Follow these steps to set up the IT Academia project on your local machine.

## Prerequisites

- Python (3.7+)
- MySQL Database Server

## Clone the Repository

```
git clone https://github.com/Ionfinisher/it-academia.git
cd it-academia
```

## Create a Virtual Environment (Optional but Recommended)


```
python3 -m venv venv
source venv/bin/activate
```

## Install Dependencies

```
pip install -r requirements.txt
```

## Configure the Database
Create a MySQL database for the project with the dump file.
Update the DATABASES configuration in it_academia/settings.py with your database settings.

## Apply Migrations
Make sure to only migrate the academia app because the admin app can cause errors

```
python manage.py makemigrations academia
python manage.py migrate academia
```

## Run the Development Server

```
python manage.py runserver
```
The IT Academia website will now be accessible at http://127.0.0.1:8000/.


## Usage
<a name="usage"></a>
Access the admin panel at http://127.0.0.1:8000/ and log in with email: admin@admin.com, password: adminitacademia to manage courses, assignments, users, and grades. </br>
Teachers can log in and create assignments for their courses.</br>
One teacher credentials: </br>
email: ferrera.marta@itacademia.com, password: Voltoche21.</br>
Students can log in, view assignments, submit solutions, and view their grades and feedback. </br>
One student credentials: </br>
email: john.doe@itacademia.com, password: Voltoche21.

## Configuration
<a name="configuration"></a>
it_academia/settings.py: Main project settings file.</br>
it_academia/urls.py: URL routing configuration.</br>
academia/models.py: Define the data models.</br>
academia/forms.py: Define forms for user interactions.</br>
academia/views.py: Implement views for rendering pages and handling requests.</br>
templates/: Contains HTML templates for rendering pages.</br>

