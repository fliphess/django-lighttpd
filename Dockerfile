FROM ubuntu:17.04
MAINTAINER Flip Hess <flip@fliphess.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && apt-get install -y lighttpd build-essential python python-dev virtualenv git
ADD conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN groupadd django && useradd -Ms /bin/bash -g django -d /opt/django django
RUN chown django:django /opt
USER django
RUN git clone https://github.com/fliphess/django-lighttpd.git /opt/django
WORKDIR /opt/django
RUN virtualenv /opt/django/.venv
RUN . /opt/django/.venv/bin/activate && \
    pip install -r requirements.txt && \
    ./manage.py migrate && \
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass')" | python manage.py shell && \
    echo yes | ./manage.py collectstatic
ENTRYPOINT /entrypoint.sh
