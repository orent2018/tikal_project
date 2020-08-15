FROM python:2-alpine

RUN apk update

RUN apk add git 

RUN git clone http://github.com/defunkt/pystache.git

WORKDIR /pystache

RUN python setup.py install

CMD ["sh"]
