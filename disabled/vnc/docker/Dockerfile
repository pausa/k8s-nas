FROM archlinux:latest
ARG UID

# This makes sure that a user with the same UID as provide: exists in the
# machine. It saves some effort in forwarding X11
RUN id -nu $UID || useradd -ms /bin/bash dev -u $UID
RUN mkdir /workspace \
 && chown $UID /workspace \
 && groupadd -r autologin \
 && usermod -d /workspace/home -m $(id -nu $UID) -G wheel,autologin

# installing yay
RUN pacman -Syyu --noconfirm --needed git base-devel
RUN echo "Defaults:dev      !authenticate" >> /etc/sudoers
RUN echo "dev   ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER $UID
WORKDIR /workspace/home
RUN git clone https://aur.archlinux.org/yay.git \
 && cd yay && makepkg -si --noconfirm

# software needed
RUN yay -Sy --noconfirm \
    xorg xorg-xinit which \
    xfce4 \
    xf86-video-dummy \
    x11vnc net-tools \
    supervisor \
    firefox \
    xdman \
    openvpn 

COPY xinitrc /workspace/home/.xinitrc

USER 0
# Xorg in headless mode
COPY 10-headless.conf /etc/X11/xorg.conf.d/10-headless.conf

# Allow non-console users to run X
# Adding startxfce to xinit
RUN echo "allowed_users = anybody" > /etc/X11/Xwrapper.config 

# Supervisord and xinit config
COPY supervisord.conf /etc/supervisord.conf

RUN dbus-uuidgen --ensure=/etc/machine-id


ENTRYPOINT supervisord

USER $UID
RUN yay -Sy --noconfirm deluge-gtk
RUN yay -Sy --noconfirm amule
