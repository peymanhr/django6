FROM python:3.14.0 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libmariadb-dev-compat \
    libmariadb-dev \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.14.0

WORKDIR /app

COPY requirements.txt /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-client \
    libmariadb3 \
    postgresql-client \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONIOENCODING="UTF-8" \
    DEBUG=False

RUN django-admin startproject app /app

LABEL org.opencontainers.image.authors="phooshmand@gmail.com"
LABEL version="1.0"

EXPOSE 80

CMD ["gunicorn", "app.wsgi:application", "--bind", "0.0.0.0:80"]
