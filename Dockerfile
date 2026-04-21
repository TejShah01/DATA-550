FROM rocker/r-ubuntu

RUN apt-get update
RUN apt-get install -y pandoc

RUN mkdir /Project
WORKDIR /Project

RUN mkdir code
RUN mkdir output
RUN mkdir Final_Report
RUN mkdir data

COPY code code
COPY data data
COPY Makefile .
COPY Final.Rmd .
COPY .Rprofile .
COPY renv.lock .

RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN Rscript -e "renv::restore(prompt = FALSE)"

CMD make && mv Final.html Final_Report/Final.html