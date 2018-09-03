FROM python:3.5 AS build-env
ENV PYTHONUNBUFFERED 1
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app/
RUN ./manage.py collectstatic --noinput

FROM nginx:1-alpine
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-env /app/icons /var/www/icons
COPY --from=build-env /app/static /var/www/static
