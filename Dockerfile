# running locally:
# docker run --name spacy_api -d -p 0.0.0.0:8042:8042/tcp lucwastiaux/spacy-api:20220918-3
# stopping:
# docker container stop spacy_api
# docker container rm spacy_api

FROM ubuntu:20.04

# use ubuntu mirrors
RUN sed -i -e 's|archive\.ubuntu\.com|mirrors\.xtom\.com\.hk|g' /etc/apt/sources.list
# install packages first
RUN apt-get update -y && apt-get install -y python3-pip

# update pip
RUN pip3 install --upgrade pip

# install requirements
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt && pip3 cache purge

# install spacy modules
RUN python3 -m spacy download en_core_web_trf
RUN python3 -m spacy download fr_dep_news_trf
RUN python3 -m spacy download zh_core_web_trf
RUN python3 -m spacy download ja_core_news_lg
RUN python3 -m spacy download de_dep_news_trf
RUN python3 -m spacy download es_dep_news_trf
RUN python3 -m spacy download ru_core_news_lg
RUN python3 -m spacy download pl_core_news_lg
RUN python3 -m spacy download it_core_news_lg

# copy app files
COPY api.py start.sh ./

EXPOSE 8042
ENTRYPOINT ["./start.sh"]
