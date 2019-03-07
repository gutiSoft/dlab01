FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
    && apt-get install -y iputils-ping
#CMD ["echo","Welcome to this container"]

## WORKDIR ##
RUN mkdir /datos /datos1
WORKDIR /datos
RUN >f1.txt
WORKDIR /datos1
RUN >f2.txt
WORKDIR /

## COPY ##
COPY index.html /datos1
COPY app.log /datos

## ADD ##  --> Hace lo mismo que copy pero...
## puede llevar tar y lo desempaqueta
## y puede traerse ficheros desde una url

## ENV ##
# Estas variables se heradan en el contenedor
# Si ejecutamos env en el contenedor aparecen: dir y dir1
ENV dir=/data dir1=/data1
RUN mkdir ${dir} && mkdir ${dir1}
##

## ARG ## --> Es similar a env pero....
## esta variable se pasa al momento de iniciar la imagen
## De esta manera puedo cambiar el comportamiento de la imagen
## A la hora de crear la imagen le paso el argumento 
## build -t image:v4 --build-arg dir2=/data2 .
## En este caso la variable NO APARECE EN EL ENV
#ARG dir2
#RUN mkdir ${dir2}
#ARG user
#ENV user_docker ${user} 
#ADD ./scripts/add_user.sh /datos1
#RUN /datos1/add_user.sh
##

## EXPOSE ## Ayuda a ver que puertos se van a usar pero....
# No los PUBLICA. Se publican con -p
RUN apt-get install -y apache2 
EXPOSE 80
ADD ./scripts/entrypoint.sh /datos1
#

## VOLUME
ADD paginas /var/www/html
VOLUME ["/var/www/html"]
# Crea ese volumen basado en la directiva ADD


CMD /datos1/entrypoint.sh
# Para arrancar correctamente la imagen:
# docker run -it --rm  -p 8080:80 image:v4


## ENTRYPOINT ##
#ENTRYPOINT  ["/bin/bash"]