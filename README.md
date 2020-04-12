# RPI4 NOOBs ICA ,BY EMULOS-TEAM
 Instalador de multiples herramientas y utilidades...

 Actualiza el firmware de su RPI4 y le instala la herramienta para 
 buscar actualizaciones del firmware automaticamente en cada inicio,
 activa y desactiva las actualizaciones de firmware automaticas en el inicio,
 instala y deja configurado AttractMode 2.6,RetroArch 1.8.1,ect ....
 
 Los que solo quieren actualizar el firmware no tienen xq intalar todas las dependencias, pueden ejecutar esto y por ssh:
 
 sudo apt-get install -y git dialog build-essential
 
 # Como usar RPI4 NOOBs ICA #
 
 NOTA: Si pretende instalar attract y retroarch con sus cores... tiene q ejecutar raspi-config ir a opciones avanzadas y en memory split poner 256
 
 
 1) Instalar dependencias: 
 IMPORTANTE NOTA: Ejecute esta instalacion de dependencias desde la misma raspberry pi4 y NO por SSH ,recuerde que si solo quiere actualizar instale simplemente estas dependencias: sudo apt-get install -y git dialog build-essential
 
 Si prentende instalar attract 2.6 y retroarch 1.8.1 instale estas como se comenta en la nota anterior.
 
 sudo apt-get install -y git dialog build-essential xinit xterm xorg xorg-dev xorg-server-source
 
 2) Clonar repo en github:
 
 git clone https://github.com/DOCK-PI3/RPI4_NOOBs_ICA.git
 
 
 3) Dar permisos de ejecucion:
 
 sudo chmod +x RPI4_NOOBs_ICA/EMULOS-TEAM_TOOL.sh
 
 
 4) Entrar en el directorio:
 
 cd RPI4_NOOBs_ICA/
 
 
 5) Ejecutar el script:
 
 ./EMULOS-TEAM_TOOL.sh
 
 
BUENA SUERTE!

![Test Image 1](https://github.com/DOCK-PI3/MasOS-Setup/blob/fkms_rpi4/tools/FELIZ_tenor.gif)

ALGUNAS CAPTURAS SOBRE ESTE SCRIPT:

![Test Image 2](https://github.com/DOCK-PI3/RPI4_NOOBs_ICA/blob/master/fotoinfo/Captura1.png)

![Test Image 3](https://github.com/DOCK-PI3/RPI4_NOOBs_ICA/blob/master/fotoinfo/Captura2.png)