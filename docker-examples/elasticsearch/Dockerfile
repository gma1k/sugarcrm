FROM elasticsearch:7.15.2
RUN groupadd -r elasticsearch && useradd --no-log-init -r -g elasticsearch elasticsearch
USER elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/
EXPOSE 9200
