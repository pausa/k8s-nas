FROM ubuntu:20.04
ARG UID

# This makes sure that a user with the same UID as provided exists in the
# machine. It saves some effort in forwarding X11
RUN id -nu $UID || useradd -ms /bin/bash dev -u $UID
RUN mkdir /workspace \
 && chown $UID /workspace \
 && usermod -d /workspace/home -m $(id -nu $UID)

RUN apt-get update -y \
    && apt-get -y install \
		fish \
		vim \
		x11-apps \
    && apt-get clean

# vnc stuff
RUN apt-get update -y \
    && apt-get -y install \
        x11vnc \
        xvfb \
    && apt-get clean

# xfce
RUN apt-get update -y \
    && apt-get -y install \
        xfce4 --no-install-recommends \
        dbus-x11 \
    && apt-get clean

# firefox n stuff
RUN apt-get update -y \
    && apt-get -y install \
        firefox \
        ffmpeg \
        wget \
    && apt-get clean

# XDM
RUN mkdir /workspace/xdm
WORKDIR /workspace/xdm
RUN wget 'https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz' -O xdm.tar.xz
RUN tar -xvf xdm.tar.xz
RUN ./install.sh

COPY entrypoint.sh /workspace/
WORKDIR /workspace/home
ENTRYPOINT ["/workspace/entrypoint.sh"]
