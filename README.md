Mininet Lab 2
=============

Get sshd working
```
sudo apt update
sudo apt purge openssh-server
sudo apt install openssh-server
```

SSH into it
```
ssh -Y mininet@<IP>
```

Install an MPTCP-capable kernel:

```
wget https://github.com/multipath-tcp/mptcp/releases/download/v0.95.2/linux-image-4.19.234.mptcp_20220311125841-1_amd64.deb
sudo dpkg -i linux-image-4.19.234.mptcp_20220311125841-1_amd64.deb
```

Comment out in /etc/default/grub
```
#GRUB_TIMEOUT_STYLE=hidden
#GRUB_TIMEOUT=0
```

Quick and dirty
---------------

If something went wrong with Mininet:
```
./clean_topology.sh
sudo mn -c
```

If you get the message "X11 connection rejected because of wrong authentication.":
```
xauth add $DISPLAY - `mcookie`
sudo cp .Xauthority /root/
```

