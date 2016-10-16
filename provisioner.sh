#!/bin/bash

dnf update --assumeyes &&
    rm -rf /etc/systemd/system/default.target &&
    ln -s /lib/systemd/system/graphical.target /etc/systemd/system/default.target &&
    (tee /etc/yum.repos.d/docker.repo <<EOF
-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/fedora/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
    ) &&
    dnf install --assumeyes docker-engine &&
    systemctl enable docker.service &&
    systemctl start docker &&
    dnf install --assumeyes kernel-devel &&
    dnf install --assumeyes gcc &&
    dnf install --assumeyes wget &&
    cd /opt &&
    wget -c http://download.virtualbox.org/virtualbox/5.1.6/VBoxGuestAdditions_5.1.6.iso -O VBoxGuestAdditions_5.1.6.iso &&
    mount VBoxGuestAdditions_5.1.6.iso -o loop /mnt &&
    cd /mnt &&
    sh VBoxLinuxAdditions.run --nox11 &&
    cd /opt &&
    dnf groupinstall --assumeyes "Basic Desktop" &&
    dnf install --assumeyes xorg-x11-server-utils systemd &&
    ls -1 volumes | while read VOLUME
    do
        docker volume create --name ${VOLUME} &&
        docker run --interactive --tty --rm --volume /vagrant/volumes/${VOLUME}:/input:ro ${VOLUME}:/output alpine:3.4 cp --archive 
        true
    done &&
    (cat > /usr/lib/systemd/service/roughfox.service <<EOF
[Unit]
Description=Rough Fox

[Service]
ExecStart=/usr/bin/xhost +

[Install]
WantedBy=multi-user.target
EOF
    ) &&
    systemctl start roughfox.service &&
    systemctl enable roughfox.service &&
    dnf update --assumeyes &&
    dnf clean all &&
    true