FROM ubuntu:20.04
ARG UID

# This makes sure that a user with the same UID as provided exists in the
# machine. It saves some effort in forwarding X11
RUN id -nu $UID || useradd -ms /bin/bash dev -u $UID
RUN mkdir /workspace \
 && chown $UID /workspace \
 && usermod -d /workspace/home -m $(id -nu $UID)

RUN apt-get -y update

RUN apt-get -y install \
		fish \
		vim \
		x11-apps 

# vnc stuff
RUN apt-get -y install \
        x11vnc \
        xvfb 

# xfce
RUN apt-get -y install \
        xfce4 --no-install-recommends \
        dbus-x11 

# firefox n stuff
RUN apt-get -y install \
        firefox \
        ffmpeg \
        wget 

# XDM
RUN mkdir /workspace/xdm
WORKDIR /workspace/xdm
RUN wget 'https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz' -O xdm.tar.xz
RUN tar -xvf xdm.tar.xz
RUN ./install.sh

# Hakuneko
RUN mkdir /workspace/hakuneko
WORKDIR /workspace/hakuneko
RUN wget 'https://github.com/manga-download/hakuneko/releases/download/v6.1.7/hakuneko-desktop_6.1.7_linux_amd64.deb' -O haku.deb
RUN apt-get -y install \
    ./haku.deb \
    libnss3

RUN apt-get -y install fonts-noto-core fontconfig
RUN apt-get -y install unzip

# cleanup and wrap up
RUN apt-get clean
COPY entrypoint.sh /workspace/
WORKDIR /workspace/home
ENTRYPOINT ["/workspace/entrypoint.sh"]
