# Используем официальный Python образ
FROM python:3.11-slim

# Устанавливаем зависимости для psycopg2 и т.п.
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

# Создадим директорию для нашего приложения
WORKDIR /app

# Скопируем requirements
COPY requirements.txt /app/

# Установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код
COPY . /app

# Применим миграции, соберём статику (если нужно)
# Выполним это позже через docker-compose командой, чтобы не жёстко зашивать в образ.

EXPOSE 8000

CMD ["gunicorn", "cms_pr.wsgi:application", "--bind", "0.0.0.0:8000"]
