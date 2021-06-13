FROM ubuntu:latest
RUN apt-get update && apt-get -y update
RUN apt-get install -y build-essential python3 python3-pip python3-dev
RUN pip3 -q install pip --upgrade

RUN mkdir /home/data
RUN mkdir /home/notebook

COPY data/.  /home/data
COPY notebook/. /home/notebook

WORKDIR /home

RUN python3 -m pip install --upgrade pip

COPY requirements.txt requirements.txt

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install jupyter


EXPOSE 8889

CMD ["jupyter", "notebook", "--port=8889", "--no-browser", "--ip=0.0.0.0", "--allow-root"]