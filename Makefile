PKGNAME=oai-gtp
VERSION=4.9
ITERATION=4

ARCH=amd64
PKGFMT=deb
WORK_DIR=/tmp/build-${PKGNAME}
PKGFILE=${PKGNAME}_${VERSION}-${ITERATION}_${ARCH}.${PKGFMT}

OUTPUT_DIR=`pwd`
OUTPUT_PATH=${OUTPUT_DIR}/${PKGFILE}

obj-m += gtp.o

build:
	make -C /lib/modules/`uname -r`/build M=$(PWD) modules
	
modules_install: build
	make INSTALL_MOD_DIR=kernel/drivers/net/ -C /lib/modules/`uname -r`/build M=$(PWD) modules_install

package: build 
	rm -rf ${WORK_DIR}
	mkdir ${WORK_DIR}
	make INSTALL_MOD_PATH=${WORK_DIR} INSTALL_MOD_DIR=kernel/drivers/net/ -C /lib/modules/`uname -r`/build M=$(PWD) modules_install
	fpm \
            -f \
	    -s dir \
	    -t ${PKGFMT} \
	    -a ${ARCH} \
	    -n ${PKGNAME} \
	    -v ${VERSION} \
	    --iteration ${ITERATION} \
	    --provides ${PKGNAME} \
	    --conflicts ${PKGNAME} \
	    --replaces ${PKGNAME} \
	    --package ${OUTPUT_PATH} \
	    --description 'Flow-based GTP kernel module' \
            --before-install scripts/before-install.sh \
            --after-install scripts/after-install.sh \
            --after-remove scripts/after-remove.sh \
	    -C ${WORK_DIR}

clean:
	make -C /lib/modules/`uname -r`/build M=$(PWD) clean
