FROM kalilinux/kali-linux-docker
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f dist-upgrade && apt-get install -y openssh-server dnsutils nmap nano tcpdump screen tmux tshark
RUN /bin/sed -i s/"PermitRootLogin prohibit-password"/"PermitRootLogin yes"/ /etc/ssh/sshd_config
RUN /bin/systemctl enable ssh
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump && hash –r
LABEL org.freenas.interactive="true" \
      org.freenas.version="3" \
      org.freenas.upgradeable="false" \
      org.freenas.port-mappings="2222:22/tcp" \
      org.freenas.expose-ports-at-host="true" \
      org.freenas.autostart="true" \
      org.freenas.command="/bin/bash" \
      org.freenas.volumes="[				\
          {						\
              \"name\": \"/root\",		\
              \"descr\": \"Presistance directory for roots home folder\"	\
          }						\
       ]"
