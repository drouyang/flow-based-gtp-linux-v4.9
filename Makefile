PKGNAME=oai-gtp
ITERATION=1
VERSION=4.9

ARCH=amd64
PKGFMT=deb
WORK_DIR=/tmp/build-${PKGNAME}
PKGFILE=${PKGNAME}_${VERSION}-${ITERATION}_${ARCH}.${PKGFMT}

OUTPUT_DIR=`pwd`
OUTPUT_PATH=${OUTPUT_DIR}/${PKGFILE}

obj-m += gtp.o

build:
	echo ${KBUILD_EXTRA_SYMBOLS}
	make -C /lib/modules/`uname -r`/build M=$(PWD) modules
	
modules_install:
	make INSTALL_MOD_DIR=kernel/drivers/net/ -C /lib/modules/`uname -r`/build M=$(PWD) modules_install

package: build 
	rm -rf ${WORK_DIR}
	mkdir ${WORK_DIR}
	make INSTALL_MOD_PATH=${WORK_DIR} INSTALL_MOD_DIR=kernel/drivers/net/ -C /lib/modules/`uname -r`/build M=$(PWD) modules_install
	fpm \
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
	    -C ${WORK_DIR}

clean:
	make -C /lib/modules/`uname -r`/build M=$(PWD) clean
