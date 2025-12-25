FROM r-base:latest

WORKDIR /home

RUN apt-get update && apt-get install -y wget bash && apt-get clean

RUN mkdir -p /home/data

RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/', dependencies=TRUE)"

COPY make_csv.R /home/make_csv.R

ENTRYPOINT ["/bin/bash", "-c"]
