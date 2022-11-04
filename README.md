Mininet Lab 2
=============

This lab will walk you through an entire experiment that demonstrates how MPTCP can better take advantage of a datacenter network's available bandwidth.
To that end, we will be using mininet to simulate a fat tree topology (shown below).

![Fatter than a sumo wrestler](https://raw.githubusercontent.com/vlolteanu/lab-mininet2/master/fat_tree.png)

The hosts will be running a random permutation traffic matrix using either
 * TCP,
 * MPTCP with 2 subflows, or
 * MPTCP with 8 subflows.

To finish up we will be plotting the throughput by rank in order to better compare the three qualitatively.

Getting things up and running
-----------------------------

**TASK 0**: Follow the instructions below.

Get the official Mininet VM: https://github.com/mininet/mininet/releases/download/2.3.0/mininet-2.3.0-210211-ubuntu-20.04.1-legacy-server-amd64-ovf.zip

Get sshd working: 
```
sudo apt update
sudo apt purge openssh-server
sudo apt install openssh-server
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

Disable MPTCP (for now):
```
sudo sysctl -w net.mptcp.mptcp_enabled=0
```

Familiarization with Gnuplot
----------------------------

A Gnuplot script suitable for producing the graph has been provided as part of the lab materials (`goodput.plot`),
along with with some unrealistic data (`tcp.dat`, `mptcp_2.dat`, `mptcp_8.dat`).

**TASK 1**: Familiarize yourself with gnuplot.
 * Inspect the four files.
 * Run the script and inspect the output. (The result is a caricature of what we'll be producing today.)

Vanilla TCP
-----------

If you've followed Task 0 to the letter, plain TCP should be in use (hint: check using `sysctl -a | grep net.mptcp.mptcp_enabled`; it should be 0).

**TASK 2**: Script the scenario. Follow the TODOs in `fat-tree.py`.
 * Start an iperf server on each of the hosts.
 * Start a 1 min random permutation traffic matrix. Each talks to some other random host, but the mapping is one-to-one: no host
 talks to two or more other hosts. Make sure the scenario is reproducible: the same random permutation must be generated every time the 
 script is run.
 * Figure out how to collect the results. We are interested in the average bandwidth of each individual flow.
 * Plot the results for vanilla TCP.
 
Multipath TCP
-------------

MPTCP can be enabled as follows:
```
sudo sysctl -w net.mptcp.mptcp_enabled=1
```
Further, we want to force MPTCP to open a certain number of subflows, regardless of the circumstances.
To do that, we employ the "ndiffports" path manager:
```
sudo sysctl -w net.mptcp.mptcp_path_manager=ndiffports
echo N > /sys/module/mptcp_ndiffports/parameters/num_subflows
```

**TASK 3**: Re-run the experiment using 2 and 8 subflows. Plot the results.

Quick and dirty troubleshooting
-------------------------------

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

