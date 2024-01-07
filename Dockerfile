FROM python:3.9-alpine

RUN apk update
RUN apk add python3-dev

WORKDIR /app

ENV FLASK_APP=flaskr

COPY requirements/base.txt ./requirements/base.txt
RUN pip3 install -r requirements/base.txt

COPY flaskr ./flaskr

EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]