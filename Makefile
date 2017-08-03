obj-m += gtp.o

all:
	echo ${KBUILD_EXTRA_SYMBOLS}
	make -C /lib/modules/`uname -r`/build M=$(PWD) modules
	
modules_install:
	make INSTALL_MOD_DIR=kernel/drivers/net/ -C /lib/modules/`uname -r`/build M=$(PWD) modules_install

clean:
	make -C /lib/modules/`uname -r`/build M=$(PWD) clean
