FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

#FROM python:3

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

ADD . / /usr/src/app/

COPY ./requirements.txt .

RUN pip install -r requirements.txt

RUN pip3 install --user https://github.com/TadaSoftware/PyNFe/archive/master.zip

CMD [ "python3", "/usr/src/app/setup.py", "install" ]
CMD [ "python3", "/usr/src/app/soap.py" ]
