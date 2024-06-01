# network configuration
network --bootproto=dhcp --device=link --activate

# Partioning Setup
clearpart --all --initlabel --disklabel=gpt
reqpart --add-boot
part / --grow --fstype xfs

# --- Container Image Installation --
ostreecontainer --url quay.io/heliumos/bootc:latest

# --- Basic Security ---
firewall --disabled # Disable the firewall (consider hardening this later)
services --enabled=sshd # Enable SSH service for remote access

rootpw --iscrypted locked #Disable direct root password login

%post

# -- systemd Services --
systemctl disable kdump.service
systemctl enable gdm.service
systemctl enable flatpak-remotes.service

%end

