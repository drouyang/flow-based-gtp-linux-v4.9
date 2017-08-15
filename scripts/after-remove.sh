GTP=/lib/modules/4.9.0-0.bpo.1-amd64/kernel/drivers/net/gtp.ko

echo "Restore $GTP ..."
if [ -f $GTP.orig ]
then
    mv $GTP.orig $GTP
fi
