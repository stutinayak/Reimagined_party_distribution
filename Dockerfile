FROM python:3.8-slim-buster

RUN mkdir /home/data
RUN mkdir /home/notebook

COPY data/.  /home/data
COPY notebook/. /home/notebook

WORKDIR /home/notebook

RUN python -m pip install --upgrade pip

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

EXPOSE 8888

ENTRYPOINT ["jupyter", "notebook","--ip=0.0.0.0","--allow-root", "--no-browser"]