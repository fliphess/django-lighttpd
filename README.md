# django-lighttpd
A basic setup to use django with uwsgi and lighttpd (Works on mac osx)

## Requirements

* `python
* `virtualenv`
* `build-essential`
* `python-dev`
* `virtualenv`
* `git`

Requires `lighttpd` version `>= 1.4.42` for [uwsgi](http://uwsgi-docs.readthedocs.io/en/latest/Lighttpd.html) [support](https://redmine.lighttpd.net/projects/lighttpd/wiki/HowToPythonWSGI)

## Setup

```bash
git clone git@github.com:fliphess/django-lighttpd.git /opt/django
virtualenv /opt/django/.venv
source /opt/django/.venv/bin/activate
pip install -r /opt/django/requirements.txt

cd /opt/django
./manage.py migrate
./manage.py createsuperuser
echo yes | ./manage.py collectstatic

```

## Start

* `bin/manage_uwsgi --start`
* `bin/manage_lighttpd --start`

## Dockerize

Building:
```bash
git clone git@github.com:fliphess/django-lighttpd.git
cd django-lighttpd
docker build -t django/lighttpd .
```

Running:
```bash
docker run -i -t --rm --dns 8.8.4.4 -p 8080:8080 django/lighttpd
```
