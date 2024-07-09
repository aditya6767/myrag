FROM nvidia/cuda:11.8.0-base-ubuntu20.04


ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt install -y --no-install-recommends software-properties-common build-essential cron g++ postgresql postgresql-contrib  vim wget cmake curl zlib1g-dev libpng-dev libjpeg-dev
RUN apt-get update && apt-get install -y python3.9 python3-pip python3-distutils python3-apt libpython3.9-dev pandoc
RUN rm -rf /usr/bin/python && ln -s /usr/bin/python3.9 /usr/bin/python &&\
    rm -rf /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip


ENV RAG_SRVHOME=/srv/home
ENV PYTHONUNBUFFERED 1

WORKDIR $RAG_SRVHOME
ADD requirements.txt $RAG_SRVHOME/
RUN pip3 install -r $RAG_SRVHOME/requirements.txt

RUN pip3 install llama-index-vector-stores-chroma
RUN pip3 install pysqlite3-binary>=3.35.0

ADD myrag $RAG_SRVHOME/myrag/
WORKDIR $RAG_SRVHOME/myrag/