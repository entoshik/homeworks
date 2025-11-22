FROM r-base:latest
WORKDIR /home
RUN mkdir -p /home/results
RUN R -e "install.packages('readxl', repos='https://cloud.r-project.org/', dependencies=TRUE)"
USER root
COPY patients.xlsx /home/scripts/
COPY HW.R /home/scripts/
CMD ["Rscript", "/home/scripts/HW.R"]