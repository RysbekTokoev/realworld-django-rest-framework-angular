#!/bin/sh

# Ожидание готовности базы данных (опционально, но полезно)
echo "Waiting for postgres..."
# Здесь можно добавить проверку через nc или pg_isready

python manage.py migrate --noinput
python manage.py collectstatic --noinput

exec "$@"
