FROM rocker/r-ver

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
  	curl \
  	wget \
  	libhdf5-dev \
  	libcurl4-gnutls-dev \
  	libssl-dev \
  	libxml2-dev \
  	libpng-dev \
  	libxt-dev \
  	zlib1g-dev \
  	libbz2-dev \
  	libgdal-dev \
  	liblzma-dev \
  	libglpk40 \
  	libgit2-dev \
    r-base && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages(c('dplyr', 'curl', 'stringr', 'httr'))"

RUN Rscript -e "install.packages(c('readr', 'shiny', 'shinydashboard', 'tidyr'))"

COPY app.R /app/app.R

WORKDIR /app

CMD Rscript app.R

EXPOSE 3838