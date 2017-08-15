GTP=/lib/modules/4.9.0-0.bpo.1-amd64/kernel/drivers/net/gtp.ko

echo "Backup $GTP ..."
if [ -f $GTP ]
then
    mv $GTP $GTP.orig
fi
