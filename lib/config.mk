WITH_LIBS=
LIBEXT=so
LIBZ=-lz
WITH_LIBS+=$(LIBZ)
WITH_LIBS+=-lresolv
PCILIB=$(LIBNAME).a
LDLIBS=$(WITH_LIBS)
LIB_LDLIBS=
PCILIBPC=$(LIBNAME).pc
PCI_CONFIG_H=1
PCI_ARCH_X86_64=1
PCI_OS_LINUX=1
PCI_HAVE_PM_LINUX_SYSFS=1
PCI_HAVE_PM_LINUX_PROC=1
PCI_HAVE_LINUX_BYTEORDER_H=1
PCI_PATH_PROC_BUS_PCI=/proc/bus/pci
PCI_PATH_SYS_BUS_PCI=/sys/bus/pci
PCI_HAVE_PM_INTEL_CONF=1
PCI_HAVE_64BIT_ADDRESS=1
PCI_HAVE_PM_DUMP=1
PCI_COMPRESSED_IDS=1
PCI_IDS=pci.ids.gz
PCI_PATH_IDS_DIR=/usr/local/share
PCI_USE_DNS=1
PCI_ID_DOMAIN=pci.id.ucw.cz
PCILIB_VERSION=3.5.1
