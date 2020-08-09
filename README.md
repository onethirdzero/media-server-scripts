# media-server-scripts

A dump of scripts I used to set up my media server.

## How to use

On a fresh install of Ubuntu, make sure the host has access to the Internet and is routable from other hosts on the network.

> For example, I did this on a Ubuntu 18.04 VM on Hyper-V. Needed to set up an [external virtual switch](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-switch-for-hyper-v-virtual-machines) and [attach](https://plexguide.com/wiki/hyper-v-windows-server/) the VM's virtual NIC to it. This works if the virtual switch is attached to the host machine's physical NIC.
>
> Didn't manage to get it working with a wireless NIC. Probably because of the reasons [here](https://docs.microsoft.com/en-us/archive/blogs/virtual_pc_guy/hyper-v-and-wireless-networking).

Then, do:

```bash
$ ./setup.sh # Set up media user and install Docker.

$ ./create-*-container.sh # Start all the containers in the media server stack.
```
