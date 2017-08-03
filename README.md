# gtp.ko: flow-based GTP tunneling 

### Features

* Flow-based GTP tunneling support.
* Out-of-tree build of the GTP kernel module. Tested with Linux v4.9.0.

### Usage

```
make
sudo make modules_install
sudo modprobe gtp
```
