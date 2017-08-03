# Off-Tree GTP Module with Flow-based Tunneling Support

## Usage

```
make
make modules_install  # this overwrites the old gtp.ko
# modprobe udp_tunnel
# modprobe ip6_udp_tunnel
modprobe gtp
```
