#!/bin/bash
clear
echo "##################################################"
echo "            USERADD WITH SMB SHARE"
echo "		           v0.5-29.04.2019"
echo "   Author: Gabriel Torelli | torelli@yahoo.com
echo "##################################################"

echo "Insert username and press [ENTER]:"
read nome

criaSenha()
{
echo "Insert password for user and press [ENTER]:"
read -s senha
echo "Confirm password and press [ENTER]:"
read -s senhaValidacao
}

criaSenha

while [[ "$senha" != "$senhaValidacao" ]]; do
echo "As senhas digitadas não são iguais!"
criaSenha
done

echo "Creating new user"
useradd -m $nome; echo "$nome:$senha" | chpasswd

echo "Adding user to samba share"
echo -e "$senha\n$senha" | smbpasswd -s -a $nome

echo "Removing wallpaper"
rm -rf /usr/share/backgrounds

#Add ANSYS software in GNOME autostart
mkdir /home/$nome/.config
mkdir /home/$nome/.config/autostart
touch /home/$nome/.config/autostart/cfx5.desktop
echo -e "[Desktop Entry]\nName=CFX5\nGenericName=CFX5\nComment=CFX5\nExec=/usr/ansys_inc/v194/CFX/bin/cfx5\nTerminal=false\nType=Application\nX-GNOME-A
utostart-enabled=true" >> /home/$nome/.config/autostart/cfx5.desktop
touch /home/$nome/.config/autostart/fluent.desktop
echo -e "[Desktop Entry]\nName=FLUENT\nGenericName=FLUENT\nComment=FLUENT\nExec=/ansys_inc/v194/fluent/bin/fluent -driver opengl\nTerminal=false\nType=
Application\nX-GNOME-Autostart-enabled=true" >> /home/$nome/.config/autostart/fluent.desktop

chmod 757 /home/$nome/.config
echo "User created! Hasta la vista baby!"
