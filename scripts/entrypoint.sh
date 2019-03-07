# Se mete en un script el arranque de un servicio porque 
# el comando RUN de docker no sirve para cambiar
# el estado de un servicio 
apachectl  start

# Una vez arrancado el servicio "Nos vamos a la bash"
/bin/bash