FROM python:3.10-trixie as base
WORKDIR app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM base AS dev
COPY . .
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

FROM base AS prod
RUN pip install gunicorn
COPY . .
RUN python manage.py collectstatic --noinput
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
