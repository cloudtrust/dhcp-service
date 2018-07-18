FROM cloudtrust-baseimage:f27

ARG service_git_tag

RUN dnf update -y && \
    dnf install -y dhcp-server && \
    dnf clean all

WORKDIR /cloudtrust
RUN git clone git@github.com:cloudtrust/dhcp-service

WORKDIR /cloudtrust/dhcp-service
RUN git checkout ${service_git_tag} && \
    install -v -m664 deploy/etc/systemd/system/dhcpd.service /etc/systemd/system/dhcpd.service

RUN systemctl enable dhcpd
