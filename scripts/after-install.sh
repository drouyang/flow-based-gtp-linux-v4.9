DEPMOD_CONFIG_DIR=/etc/depmod.d/
DEPMOD_CONFIG_FILE=${DEPMOD_CONFIG_DIR}/gtp.conf

mkdir -p ${DEPMOD_CONFIG_DIR}
echo "override gtp * extra" >> ${DEPMOD_CONFIG_FILE}
echo "override gtp.ko * weak-updates" >> ${DEPMOD_CONFIG_FILE}

echo "Running depmod..."
depmod `uname -r`
