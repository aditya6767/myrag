FROM nvidia/cuda:11.8.0-base-ubuntu22.04


ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt install -y --no-install-recommends software-properties-common build-essential cron g++ postgresql postgresql-contrib  vim wget cmake curl zlib1g-dev libpng-dev libjpeg-dev && add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.9 python3.9-distutils python3-apt pandoc && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9

# Create a symbolic link to make python3 point to python3.9
RUN rm -rf /usr/bin/python3 && ln -s /usr/bin/python3.9 /usr/bin/python3

# Install additional packages (optional)
RUN apt-get install -y python3-venv python3-dev


ENV RAG_SRVHOME=/srv/home
ENV PYTHONUNBUFFERED 1

WORKDIR $RAG_SRVHOME
ADD requirements.txt $RAG_SRVHOME/
RUN pip3 install -r $RAG_SRVHOME/requirements.txt

RUN pip3 install llama-index-vector-stores-chroma

ADD myrag $RAG_SRVHOME/myrag/
WORKDIR $RAG_SRVHOME/myrag/