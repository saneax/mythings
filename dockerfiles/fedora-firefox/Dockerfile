FROM fedora:latest
LABEL "Author"="Sanjay Upadhyay <saneax@gmail.com>"
LABEL "in.saneax.author"="saneax@gmail.com"
LABEL version="1.0"
LABEL description="This Container starts a fedora based google chrome"

LABEL RUN='docker run -d -p 5901:5901 -v /etc/machine-id:/etc/machine-id:ro $IMAGE'

RUN rpm -ivh https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm

ADD google-chrome.repo /etc/yum.repos.d/

RUN yum clean all && yum update -y

RUN dnf -y install xorg-x11-twm \
                   tigervnc-server \
                   xterm \
                   dejavu-sans-fonts  \
                   dejavu-serif-fonts \
                   gstreamer \
                   gstreamer-ffmpeg \
                   gstreamer-plugins-bad \
                   gstreamer-plugins-bad-free \
                   gstreamer-plugins-base \
                   gstreamer-plugins-good \
                   gstreamer-plugins-ugly \
                   gstreamer-plugin-crystalhd \
                   gstreamer1-plugins-bad-freeworld \
                   gstreamer1-plugins-bad-free \
                   gstreamer1-plugins-good \
                   gstreamer1-libav \
                   ffmpeg \
                   xdotool  \
									 google-chrome && \
    dnf clean all



# Add the xstartup file into the image and set the default password.
RUN mkdir /root/.vnc
ADD ./xstartup /root/.vnc/
RUN chmod -v +x /root/.vnc/xstartup
RUN echo 123456 | vncpasswd -f > /root/.vnc/passwd
RUN chmod -v 600 /root/.vnc/passwd

RUN sed -i '/\/etc\/X11\/xinit\/xinitrc-common/a [ -x /usr/bin/google-chrome ] && /usr/bin/google-chrome &' /etc/X11/xinit/xinitrc

RUN dnf install -y mesa-dri-drivers \
                   xauth \
                   openssh-server \
                   passwd && dnf clean all

EXPOSE 5901 22

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

