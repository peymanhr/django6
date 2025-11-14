# Django 5 docker image

A genertic Django5 docker image

## python3.14.0
```
docker build -t django:5.2.8-python3.14.0 django5
```

## python3.14.0-slim
```
docker build -f django5/Dockerfile-slim -t django:5.2.8-python3.14.0-slim django5
```

## python3.14.0-alpine3.21
```
docker build -f django5/Dockerfile-alpine -t django:5.2.8-python3.14.0-alpine3.21 django5
```
