#!/bin/bash
version=" 1.0.1"
infobox="${infobox}\n_______________________________________________________\n\n"
infobox="${infobox}\n       EMULOS-TEAM_TOOL creado para ayudar a los novatos .....\n\nRPI4_NOOBs_ICA: Instalador de multiples herramientas y utilidades.....\n"
infobox="${infobox}\n\n_______________________________________________________\n\n"
#infobox="${infobox}\n       AttractMode 2.6,RetroArch 1.8.1 ,WebMin ,Mumble server\n\nSamba ,vsFTPd ,Duck DNS ,Pi-Hole ,Pi-VPN ,EmulOS ,EmuCOPS NOOBs v1 y MasOS."
infobox="${infobox}\n\n\n_______________________________________________________\n\n"
dialog --backtitle "Version de la aplicacion: $version - Multi-instalador de Herramientas y utils" \
--title "Instalador de sistemas y utilidades rpi 4b (by EmulOS TEAM)" \
--msgbox "${infobox}" 35 110

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Version: $version - Que accion te gustaria realizar?" 25 75 20 \
			100 "-------------- Para RPI4 ----------------" \
			70 "Rpi4 Instala Retroarch 1.8.1" \
			71 "Rpi4 Retroarch install CORES" \
			72 "Rpi4 Instala AttractMode - Alternate version X" \
			73 "Rpi4 Instalar herramienta y actualiza el firmware de tu rpi4" \
			74 "Rpi4 Desactivar auto-updates del Firmware para su RPI4 " \
			75 "Rpi4 Activar auto-updates del Firmware para su RPI4 en el inicio" \
			100 "-------------- OPCIONES ATTRACTMODE AUTOSTART ----------------" \
			300 "Rpi AttractMode inicio auto CLI consola - version Raspian lite" \
			320 "Rpi AttractMode inicio auto Escritorio - version Raspian Desktop" \
			100 "-------------- RPI4_NOOBs_ICA ACTUALIZAR VERSION ----------------" \
			69 "######## ACTUALIZAR herramienta RPI4_NOOBs_ICA ########" \
			2>&1 > /dev/tty)

        case "$choice" in
			100) separador_menu  ;;
			69) EMULOS-TEAM_TOOL_update ;;
			70) RPI4_retroarch_instalador ;;
			71) RPI4_retroarch_install_cores ;;
			72) RPI4_attractmode_instalador ;;
			73) RPI4_installauto_updatefirmw ;;
			74) RPI4_FIRMWARE_AutoupdateOFF ;;
			75) RPI4_FIRMWARE_AutoupdateON ;;
			300) consola_attract_autolaunch  ;;
            320) desktop_attract_autolaunch  ;;
			*)  break ;;
        esac
    done
}

function separador_menu() {                                          
dialog --infobox "... Separador para el menu, sin funcion ..." 30 55 ; sleep 2
}

function RPI4_installauto_updatefirmw() {
dialog --infobox "... RPI4 Instala Actualizador de Firmware y actualiza ..." 30 55 ; sleep 3
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y rpi-eeprom rpi-eeprom-images
# dialog --infobox "... Buscando Actualizaciones para el Firmware de RPI4 \n\n Si la busqueda da positivo puede actualizar el firmware \n\n usando la opcion 74 RPI4 UPDATE FIRMWARE, para desactivar las actualizaciones automaticas ejecute \n\n\n\n COMANDO: sudo systemctl mask rpi-eeprom-update \n\n\n\nPara reactivar las updates auto del firmware ejecute \n\n\n\n COMANDO: sudo systemctl unmask rpi-eeprom-update " 30 55 ; sleep 2
# sudo rpi-eeprom-update
dialog --infobox "... Firmware de rpi4 actualizado correctamente. Reiniciando en 8s ..." 30 55 ; sleep 8
sudo reboot
}

function RPI4_FIRMWARE_AutoupdateOFF() {
dialog --infobox "... Desactivando auto-updates del Firmware para su RPI4 ..." 30 55 ; sleep 2
sudo systemctl mask rpi-eeprom-update
dialog --infobox "... Puede actualizar de forma manual o activar las auto-updates del firmware en la opcion 75 cuando lo crea oportuno ...  " 30 55 ; sleep 10
}

function RPI4_FIRMWARE_AutoupdateON() {
dialog --infobox "... Activando auto-updates del Firmware para su RPI4 en el inicio ..." 30 55 ; sleep 2
sudo systemctl unmask rpi-eeprom-update
dialog --infobox "... En el proximo inicio del sistema se buscaran actualizaciones, reinicie si lo desea ...  " 30 55 ; sleep 10
}

function consola_attract_autolaunch() {                                          
dialog --infobox "... INICIO DE ATTRACT AUTO EN CLI - CONSOLA ..." 30 55 ; sleep 2
cd && cp .bashrc .bashrc_back
cd && sudo cp RPI4_NOOBs_ICA/configs/rpi4/.bashrc /home/pi/
sudo chown -R pi:pi /home/pi/.bashrc
dialog --infobox "... REINICIANDO CON INICIO AUTO DE ATTRACT EN MODO CLI - CONSOLA ..." 30 55 ; sleep 5
sudo reboot
}

function desktop_attract_autolaunch() {                                          
dialog --infobox "... INICIO DE ATTRACT AUTO EN DESKTOP ..." 30 55 ; sleep 2
cd && sudo cp RPI4_NOOBs_ICA/configs/icon_attract.png /usr/share/icons/
sudo touch /usr/local/share/applications/attract.desktop
sudo cat > /usr/local/share/applications/attract.desktop <<_EOF_
[Desktop Entry]
Version=1.0
Name=AttractMode
Comment=EMUCOPS Emulator Frontend
Exec=/usr/local/bin/attract
Terminal=false
Type=Application
Categories=Game
Icon=/usr/share/icons/icon_attract.png
Name[es_ES]=Attract
_EOF_
cd /home/pi/.config/ && sudo mkdir autostart
sudo cp /usr/local/share/applications/attract.desktop /home/pi/.config/autostart/

#sudo reboot
}


function EMULOS-TEAM_TOOL_update() {                                          
dialog --infobox "... Actualiza la herramienta RPI4 NOOBs ICA..." 30 55 ; sleep 3
cd && sudo rm -R RPI4_NOOBs_ICA/
git clone https://github.com/DOCK-PI3/RPI4_NOOBs_ICA.git
sudo chmod +x RPI4_NOOBs_ICA/EMULOS-TEAM_TOOL.sh
cd RPI4_NOOBs_ICA/ && ./EMULOS-TEAM_TOOL.sh
exit
}

# function emulos_instalador() {                                          
# dialog --infobox "... Script instalador de EmulOS en su version mas reciente ...\n\n" 30 55 ; sleep 3
# sudo apt-get update
# sudo apt-get install -y git
# cd && git clone --depth=1 https://github.com/Moriggy/EmulOS-Setup.git
# cd EmulOS-Setup
# sudo ./emulos_setup.sh
# }

function RPI4_retroarch_instalador() {                                          
dialog --infobox "... RIP4 BETA Script instalador de Retroarch en su version 1.8.1 ..." 30 55 ; sleep 5
sudo apt-get update
dialog --infobox "... Iniciando actualizacion del sistema y sus paquetes ,comentado dmomento..." 30 55 ; sleep 5
sudo apt upgrade -y
dialog --infobox "... Elija la distribucion para su teclado ..." 30 55 ; sleep 5
sudo dpkg-reconfigure keyboard-configuration
dialog --infobox "... Seleccione con espacio es_ES.UTF-8 si vive en España y pulse enter..." 30 55 ; sleep 5
sudo dpkg-reconfigure locales
dialog --infobox "... Elija su zona horaria ..." 30 55 ; sleep 5
sudo dpkg-reconfigure tzdata
dialog --infobox "... Compilar e instalar RetroArch ,iniciando espere! ..." 30 55 ; sleep 5
#sudo apt-get install -y build-essential libasound2-dev libudev-dev libgles2-mesa-dev libz-dev libpng-dev
#sudo apt-get install -y build-essential libxkbcommon-dev zlib1g-dev libfreetype6-dev libegl1-mesa-dev libasound2-dev libudev-dev libgles2-mesa-dev libgles2-mesa-dev libgbm-dev nvidia-cg-toolkit nvidia-cg-dev libavcodec-dev libsdl2-dev libsdl-image1.2-dev libxml2-dev yasm
sudo apt-get install -y build-essential libasound2-dev libudev-dev libxkbcommon-dev zlib1g-dev libfreetype6-dev libegl1-mesa-dev libgles2-mesa-dev libgbm-dev libavcodec-dev libsdl2-dev libsdl-image1.2-dev libxml2-dev yasm libavformat-dev libavdevice-dev libswresample-dev libavresample-dev libswscale-dev libv4l-dev libgl*-mesa-dev
#build-essential libxkbcommon-dev zlib1g-dev libfreetype6-dev libegl1-mesa-dev libasound2-dev libgles2-mesa-dev libgbm-dev libavcodec-dev libsdl2-dev libsdl-image1.2-dev libxml2-dev yasm libavformat-dev libavdevice-dev libswresample-dev libavresample-dev libswscale-dev libv4l-dev libgl*-mesa-dev

cd && curl -LO 'https://github.com/libretro/RetroArch/archive/v1.8.1.tar.gz' && tar -zxvf v1.8.1.tar.gz
sudo rm v1.8.1.tar.gz
cd RetroArch-1.8.1
CFLAGS='-mfpu=neon -mtune=cortex-a72 -march=armv8-a' ./configure --disable-opengl1 --enable-neon --enable-opengles3 --enable-opengles --enable-udev --disable-videocore
#CFLAGS="-mfpu=neon" ./configure --disable-videocore --enable-opengl --disable-opengl1 --enable-alsa --enable-udev --disable-opengles --enable-neon
make -j4
sudo make install
cd && sudo rm -R RetroArch-1.8.1/

##### instalar bios base
dialog --infobox "... Descargando y Copiando BIOS BASE para retroarch en /home/pi/.config/retroarch/system ..." 30 55 ; sleep 3
cd && mkdir /home/pi/.config/
cd && mkdir /home/pi/.config/retroarch/
cd && mkdir /home/pi/.config/retroarch/cores/
cd && mkdir /home/pi/.config/retroarch/system/
##### cargar configuracion retroarch
cd && cp RPI4_NOOBs_ICA/configs/rpi4/retroarch.cfg /home/pi/.config/retroarch/
cd && git clone https://github.com/DOCK-PI3/rpi-retroarch-bios.git
cd && cp -R rpi-retroarch-bios/system/* /home/pi/.config/retroarch/system/
sudo rm -R /home/pi/rpi-retroarch-bios/
##### add default shaders rpi ok...
cd && git clone https://github.com/DOCK-PI3/emucops-retroarch-shaders.git
cd && cp -R emucops-retroarch-shaders/shaders /home/pi/.config/retroarch/
sudo rm -R /home/pi/emucops-retroarch-shaders/

dialog --infobox "... Descarga de BIOS BASE: correcta ..." 30 55 ; sleep 3
dialog --infobox "... RetroArch 1.8.1 instalado y configurado correctamente en su rpi4! ..." 30 55 ; sleep 7
}

#################################################
function RPI4_attractmode_instalador() {                                          
dialog --infobox "... RPI4 Script instalador de AttractMode en su version mas reciente ..." 30 55 ; sleep 3
# Cierra ES para una mejor y mas rapida compilacion de attract y ffmpeg......
# sudo killall emulationstation
# sudo killall emulationstation-dev

# ACTUALIZAR LISTA DE PAQUETES
sudo apt-get update

#  libjpeg8-dev - prueba change to libjpeg-dev
# Instalar las dependencias para "sfml-pi" y Attract-Mode ### git-core comment...
sudo apt-get install -y git cmake make pkg-config libraspberrypi-dev libavformat-dev libavfilter-dev libswscale-dev libavresample-dev libavutil-dev libjpeg-dev libavcodec-dev libflac-dev libogg-dev libvorbis-dev libopenal-dev libfreetype6-dev libudev-dev libfontconfig1-dev
# Dependencia para ejecutar attract en buster RPI4 - xinit attract #
sudo apt-get install -y xinit
#sudo apt-get install -y libx11-dev libx11-xcb-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-icccm4-dev libxrandr2 libxrandr-dev libgles2-mesa-dev
         
#Descargar y compilar mpv
sudo apt-get install -y mpv

#Descargar e instalar sfml-pi
sudo apt-get install -y libsfml-dev

# cd /home/pi/develop
# git clone --depth 1 https://github.com/mickelson/sfml-pi sfml-pi
# mkdir sfml-pi/build; cd sfml-pi/build
# #cmake -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DFREETYPE_INCLUDE_DIR_freetype2=/usr/include -DFREETYPE_INCLUDE_DIR_ft2build=/usr/include/freetype2 -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so -DSFML_BCMHOST=1 -DSFML_OPENGL_ES=1 ..
# cmake -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libbrcmEGL.so -DFREETYPE_INCLUDE_DIR_freetype2=/usr/include -DFREETYPE_INCLUDE_DIR_ft2build=/usr/include/freetype2 -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libbrcmGLESv2.so -DSFML_BCMHOST=1 -DSFML_OPENGL_ES=1 ..
# sudo make -j4 install
# sudo ldconfig

# Crear entorno para compilar
cd /home/pi && mkdir develop
# Compilar FFmpeg con soporte mmal (decodificacion de video acelerada por hardware)
cd /home/pi/develop
git clone --depth 1 git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
./configure --enable-mmal --disable-debug --enable-shared
make -j4
sudo make -j4 install
sudo ldconfig

# Descargar y compilar Attract-Mode
cd && mkdir /home/pi/.attract
cd /home/pi/develop && git clone https://github.com/mickelson/attract attract
#dpkg-buildpackage -rfakeroot
cd attract && make USE_GLES=1
sudo make install
sudo rm -r -f /home/pi/develop
# dialog --infobox " Ahora se abre attract mode, una vez que inicie attract seleccione su idioma \n y luego cierre atrract mode para seguir con la configuracion. " 350 350 ; sleep 10

xinit attract
killall attract

#### config full rescue ######
cd && git clone https://github.com/DOCK-PI3/EmuCOPS-Attract-autoconf.git
cp -R /home/pi/EmuCOPS-Attract-autoconf/attract/* /home/pi/.attract/
cd && mkdir EmuCOPS
cp -R /home/pi/EmuCOPS-Attract-autoconf/EmuCOPS/* /home/pi/EmuCOPS/
sudo rm -R /home/pi/EmuCOPS-Attract-autoconf

# Permisos rutas attract #
sudo chown -R pi:pi /usr/local/bin/attract
sudo chown -R pi:pi /usr/local/share/attract/
sudo chown -R pi:pi /home/pi/.attract/

dialog --infobox "... CREANDO INICIO DE ATTRACT AUTO EN CLI - CONSOLA ..." 30 55 ; sleep 5
cd && cp .bashrc .bashrc_back
cd && sudo cp RPI4_NOOBs_ICA/configs/rpi4/.bashrc /home/pi/
sudo chown -R pi:pi /home/pi/.bashrc
dialog --infobox " ...Attractmode instalado y con inicio automatico... " 350 350 ; sleep 10
}

function RPI4_retroarch_install_cores() {                                          
dialog --infobox "... RPI4 Retroarch instalando core \n\n CORES: ..." 30 55 ; sleep 3
cd ~
mkdir EmUCoP-cores
cd EmUCoP-cores
dialog --infobox "... RPI4 Retroarch instalando core libretro-fceumm ..." 30 55 ; sleep 2
git clone --depth 1 https://github.com/libretro/libretro-fceumm.git
cd libretro-fceumm
make -j3

dialog --infobox "... RPI4 Retroarch instalando core snes9x2010 ..." 30 55 ; sleep 2
cd ~
cd EmUCoP-cores
git clone --depth 1 https://github.com/libretro/snes9x2010.git
cd snes9x2010
make -j3

dialog --infobox "... RPI4 Retroarch instalando core mupen64plus-libretro ..." 30 55 ; sleep 2
cd ~
cd EmUCoP-cores
git clone --depth 1 https://github.com/libretro/mupen64plus-libretro.git
cd mupen64plus-libretro
platform=rpi4 make -j3

dialog --infobox "... RPI4 Retroarch instalando core  pcsx_rearmed ..." 30 55 ; sleep 2
cd ~
cd EmUCoP-cores
git clone --depth 1 https://github.com/libretro/pcsx_rearmed.git
cd pcsx_rearmed
platform=rpi4 make -f Makefile.libretro

dialog --infobox "... Descargando y Copiando mas de 70 cores para retroarch en /home/pi/.config/retroarch/cores ..." 30 55 ; sleep 5
cd && git clone https://github.com/DOCK-PI3/LR-CORES-RPI4.git
cd && cp -R LR-CORES-RPI4/*.so /home/pi/.config/retroarch/cores

cd && cp -R EmUCoP-cores/libretro-fceumm/*.so /home/pi/.config/retroarch/cores
cd && cp -R EmUCoP-cores/snes9x2010/*.so /home/pi/.config/retroarch/cores
cd && cp -R EmUCoP-cores/mupen64plus-libretro/*.so /home/pi/.config/retroarch/cores
cd && cp -R EmUCoP-cores/pcsx_rearmed/pcsx_rearmed_libretro.so /home/pi/.config/retroarch/cores/

dialog --infobox "... FlyCast y Mas de 70 Cores instalados de forma correcta, cores for neos flags optimece.. limpiando basura...." 30 55 ; sleep 2
sudo rm -R /home/pi/EmUCoP-cores/
sudo rm -R /home/pi/LR-CORES-RPI4/
}

main_menu