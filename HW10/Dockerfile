FROM r-base:latest
WORKDIR /home
RUN mkdir -p /home/data
RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/', dependencies=TRUE)"
USER root
COPY make_csv.R /home/
CMD ["Rscript", "-e", "if(requireNamespace('dplyr', quietly=TRUE)) { cat('dplyr версия:', as.character(packageVersion('dplyr')), '\n') } else { stop('dplyr не установлен!') }; source('/home/make_csv.R')"]