FROM python:3.9

ENV RAG_SRVHOME=/srv/home
ENV PYTHONUNBUFFERED 1

WORKDIR $RAG_SRVHOME
ADD requirements.txt $RAG_SRVHOME/
RUN pip install -r $RAG_SRVHOME/requirements.txt

ADD my_rag $RAG_SRVHOME/my_rag/
WORKDIR $RAG_SRVHOME/my_rag/