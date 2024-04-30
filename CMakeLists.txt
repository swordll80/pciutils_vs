cmake_minimum_required(VERSION 3.13)

#project(pciutils VERSION 3.5.1 language C)
project(pciutils)
set(PROJECT_VERSION 3.5.1)
set(PROJECT_LANGUAGE C)


set(CMAKE_C_COMPILER "/opt/rh/devtoolset-10/root/usr/bin/gcc")
#set(CMAKE_C_COMPILER "/opt/gcc-10.2/bin/gcc")
#set(CMAKE_CXX_COMPILER "/opt/rh/devtoolset-10/root/usr/bin/g++")

# 检查GCC版本是否满足最低要求
execute_process(
  COMMAND ${CMAKE_C_COMPILER} -dumpversion
  OUTPUT_VARIABLE GCC_VERSION
)
if(GCC_VERSION VERSION_LESS 10)
    message(FATAL_ERROR "GCC version must be at least 10.2! Current version: ${GCC_VERSION}")
endif()

#C90=C89
#set(CMAKE_C_STANDARD 90)
#set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD 11)
#set(CMAKE_CXX_STANDARD 17)

#C++
# set(CMAKE_CXX_STANDARD 11)

set(DATE "2016-05-19")
option(ZLIB "Support for compressed pci.ids (yes/no, default: detect)" "")
option(DNS "Support for resolving ID's by DNS (yes/no, default: detect)" "")
#        SHARED
# option(SHARED "Build libpci as a shared library (yes/no; or local for testing; requires GCC)" "no")
# add_definitions(-DSHARED=no)
set(SHARED no)
option(LIBKMOD "Use libkmod to resolve kernel modules on Linux (yes/no, default: detect)" "")
option(HWDB "Use libudev to resolve device names using hwdb on Linux (yes/no, default: detect)" "")
option(ABI_VERSION "ABI version suffix in the name of the shared library (as we use proper symbol versioning, this seldom needs changing)" ".3")

# Installation directories
set(PREFIX "/usr/local")
set(SBINDIR "${PREFIX}/sbin")
set(SHAREDIR "${PREFIX}/share")
set(IDSDIR "${SHAREDIR}")
execute_process(COMMAND sh -c "if [ -d ${PREFIX}/share/man ] ; then echo ${PREFIX}/share/man ; else echo ${PREFIX}/man ; fi" OUTPUT_VARIABLE MANDIR)
set(INCDIR "${PREFIX}/include")
set(LIBDIR "${PREFIX}/lib")
set(PKGCFDIR "${LIBDIR}/pkgconfig")

# Commands
set(INSTALL install)
set(DIRINSTALL install -d)
set(STRIP -s)
set(CC ${CROSS_COMPILE}gcc)
set(AR ${CROSS_COMPILE}ar)
set(RANLIB ${CROSS_COMPILE}ranlib)

# Base name of the library (overridden on NetBSD, which has its own libpci)
set(LIBNAME "libpci")

# Include lib/config.mk if it exists
# file(GLOB CONFIG_FILE "lib/config.mk")
# if(EXISTS ${CONFIG_FILE})
#     include(${CONFIG_FILE})
# endif()

# 设置WITH_LIBS
set(WITH_LIBS "")

# 设置LIBEXT
set(LIBEXT "so")

# 设置LIBZ
set(LIBZ "-lz")

# 添加LIBZ到WITH_LIBS
list(APPEND WITH_LIBS ${LIBZ})

# 添加-lresolv到WITH_LIBS
list(APPEND WITH_LIBS -lresolv)

# 设置PCILIB
set(PCILIB "${LIBNAME}.a")

# 设置LDLIBS为WITH_LIBS
set(LDLIBS ${WITH_LIBS})

# 设置LIB_LDLIBS为空
set(LIB_LDLIBS "")

# 设置PCILIBPC
set(PCILIBPC "${LIBNAME}.pc")

# 设置PCI_CONFIG_H为1
set(PCI_CONFIG_H 1)

# 设置PCI_ARCH_X86_64为1
set(PCI_ARCH_X86_64 1)

# 设置PCI_OS_LINUX为1
set(PCI_OS_LINUX 1)

# 设置PCI_HAVE_PM_LINUX_SYSFS为1
set(PCI_HAVE_PM_LINUX_SYSFS 1)

# 设置PCI_HAVE_PM_LINUX_PROC为1
set(PCI_HAVE_PM_LINUX_PROC 1)

# 设置PCI_HAVE_LINUX_BYTEORDER_H为1
set(PCI_HAVE_LINUX_BYTEORDER_H 1)

# 设置PCI_PATH_PROC_BUS_PCI
set(PCI_PATH_PROC_BUS_PCI "/proc/bus/pci")

# 设置PCI_PATH_SYS_BUS_PCI
set(PCI_PATH_SYS_BUS_PCI "/sys/bus/pci")

# 设置PCI_HAVE_PM_INTEL_CONF为1
set(PCI_HAVE_PM_INTEL_CONF 1)

# 设置PCI_HAVE_64BIT_ADDRESS为1
set(PCI_HAVE_64BIT_ADDRESS 1)

# 设置PCI_HAVE_PM_DUMP为1
set(PCI_HAVE_PM_DUMP 1)

# 设置PCI_COMPRESSED_IDS为1
set(PCI_COMPRESSED_IDS 1)

# 设置PCI_IDS
set(PCI_IDS "pci.ids.gz")

# 设置PCI_PATH_IDS_DIR
set(PCI_PATH_IDS_DIR "/usr/local/share")

# 设置PCI_USE_DNS为1
set(PCI_USE_DNS 1)

# 设置PCI_ID_DOMAIN
set(PCI_ID_DOMAIN "pci.id.ucw.cz")

# 设置PCILIB_VERSION
set(PCILIB_VERSION "3.5.1")


# Define PCIINC and PCIINC_INS
set(PCIINC "lib/config.h" "lib/header.h" "lib/pci.h" "lib/types.h" "lib/sysdep.h")
set(PCIINC_INS "lib/config.h" "lib/header.h" "lib/pci.h" "lib/types.h")

# Export variables
# export()


add_compile_options(-Wall)
# add_compile_options(-Wextra)
# add_compile_options(-frequire-return-statement) #is valid for Go but not for C
add_compile_options(-W)
add_compile_options(-Wno-parentheses)
add_compile_options(-Wstrict-prototypes)
add_compile_options(-Wmissing-prototypes)


# 设置变量
set(LIBNAME "libpci")
set(PCILIB "${LIBNAME}.a") # PCILIB=libpci.a
set(PCILIBPC "${LIBNAME}.pc") # PCILIBPC=libpci.pc
set(PCIDS "pci.ids") # 假设PCI_IDS为pci.ids
set(LIBKMOD_LIBS "") # 假设LIBKMOD_LIBS为空
set(LIBKMOD_CFLAGS "") # 假设LIBKMOD_CFLAGS为空

# 设置源文件列表
set(LSPCI_SOURCES
    lspci.c
    ls-vpd.c
    ls-caps.c
    ls-caps-vendor.c
    ls-ecaps.c
    ls-kernel.c
    ls-tree.c
    ls-map.c
    common.c
    ./lib/init.c
    ./lib/access.c
    ./lib/generic.c
    ./lib/dump.c
    ./lib/names.c
    ./lib/filter.c
    ./lib/names-hash.c
    ./lib/names-parse.c
    ./lib/names-net.c
    ./lib/names-cache.c
    ./lib/names-hwdb.c
    ./lib/params.c
    ./lib/caps.c
)

set(SETPCI_SOURCES
    setpci.c
    common.c
    ./lib/init.c
    ./lib/access.c
    ./lib/generic.c
    ./lib/dump.c
    ./lib/names.c
    ./lib/filter.c
    ./lib/names-hash.c
    ./lib/names-parse.c
    ./lib/names-net.c
    ./lib/names-cache.c
    ./lib/names-hwdb.c
    ./lib/params.c
    ./lib/caps.c
)

set(EXAMPLE_SOURCES
    example.c
    ./lib/init.c
    ./lib/access.c
    ./lib/generic.c
    ./lib/dump.c
    ./lib/names.c
    ./lib/filter.c
    ./lib/names-hash.c
    ./lib/names-parse.c
    ./lib/names-net.c
    ./lib/names-cache.c
    ./lib/names-hwdb.c
    ./lib/params.c
    ./lib/caps.c
)

# 设置头文件列表
set(HEADERS
    lspci.h
    pciutils.h
    lib/config.h
    lib/header.h
    lib/pci.h
    lib/types.h
)

# libpci.a
# 设置源文件
set(LIBPCI_SOURCES
    ./lib/init.c
    ./lib/access.c
    ./lib/generic.c
    ./lib/dump.c
    ./lib/names.c
    ./lib/filter.c
    ./lib/names-hash.c
    ./lib/names-parse.c
    ./lib/names-net.c
    ./lib/names-cache.c
    ./lib/names-hwdb.c
    ./lib/params.c
    ./lib/caps.c
)

# 根据环境变量添加源文件
if(PCI_HAVE_PM_LINUX_SYSFS)
    list(APPEND LSPCI_SOURCES ./lib/sysfs.c)
    list(APPEND SETPCI_SOURCES ./lib/sysfs.c)
    list(APPEND EXAMPLE_SOURCES ./lib/sysfs.c)
endif()

if(PCI_HAVE_PM_LINUX_PROC)
    list(APPEND LSPCI_SOURCES ./lib/proc.c)
    list(APPEND SETPCI_SOURCES ./lib/proc.c)
    list(APPEND EXAMPLE_SOURCES ./lib/proc.c)
endif()

if(PCI_HAVE_PM_INTEL_CONF)
    list(APPEND LSPCI_SOURCES ./lib/i386-ports.c)
    list(APPEND SETPCI_SOURCES ./lib/i386-ports.c)
    list(APPEND EXAMPLE_SOURCES ./lib/i386-ports.c)
endif()

if(PCI_HAVE_PM_DUMP)
    list(APPEND LSPCI_SOURCES ./lib/dump.c)
    list(APPEND SETPCI_SOURCES ./lib/dump.c)
    list(APPEND EXAMPLE_SOURCES ./lib/dump.c)
endif()

if(PCI_HAVE_PM_FBSD_DEVICE)
    list(APPEND LSPCI_SOURCES ./lib/fbsd-device.c)
    list(APPEND SETPCI_SOURCES ./lib/fbsd-device.c)
    list(APPEND EXAMPLE_SOURCES ./lib/fbsd-device.c)
    # 添加FreeBSD系统头文件路径
    include_directories(/usr/src/sys)
    if(FREEBSD_SYS)
        include_directories(${FREEBSD_SYS})
    endif()
endif()

if(PCI_HAVE_PM_OBSD_DEVICE)
    list(APPEND LSPCI_SOURCES ./lib/obsd-device.c)
    list(APPEND SETPCI_SOURCES ./lib/obsd-device.c)
    list(APPEND EXAMPLE_SOURCES ./lib/obsd-device.c)
endif()

if(PCI_HAVE_PM_AIX_DEVICE)
    list(APPEND LSPCI_SOURCES ./lib/aix-device.c)
    list(APPEND SETPCI_SOURCES ./lib/aix-device.c)
    list(APPEND EXAMPLE_SOURCES ./lib/aix-device.c)
endif()

if(PCI_HAVE_PM_NBSD_LIBPCI)
    list(APPEND LSPCI_SOURCES ./lib/nbsd-libpci.c)
    list(APPEND SETPCI_SOURCES ./lib/nbsd-libpci.c)
    list(APPEND EXAMPLE_SOURCES ./lib/nbsd-libpci.c)
endif()

if(PCI_HAVE_PM_DARWIN_DEVICE)
    list(APPEND LSPCI_SOURCES ./lib/darwin.c)
    list(APPEND SETPCI_SOURCES ./lib/darwin.c)
    list(APPEND EXAMPLE_SOURCES ./lib/darwin.c)
endif()

# 添加头文件路径
include_directories(${CMAKE_CURRENT_SOURCE_DIR})


find_package(ZLIB REQUIRED)

if(NOT DEFINED SHARED OR SHARED STREQUAL "no")
    # 添加静态库目标
    add_library(pci STATIC ${LIBPCI_SOURCES})
    target_link_libraries(pci PRIVATE ZLIB::ZLIB)
else()
    # 添加共享库目标
    add_library(pci SHARED ${LIBPCI_SOURCES})
    # 添加编译选项
    add_compile_options(-fPIC -fvisibility=hidden)
    # 判断是否为Darwin系统，设置链接选项
    if(PCI_HAVE_PM_DARWIN_DEVICE)
        set_target_properties(pci PROPERTIES INSTALL_RPATH "${LIBDIR}")
        set_target_properties(pci PROPERTIES LINK_FLAGS "-install_name ${LIBDIR}/${PCILIB}")
    else()
        set_target_properties(pci PROPERTIES LINK_FLAGS "--version-script=libpci.ver")
    endif()
endif()


# 设置共享库的版本号
# set_target_properties(pci PROPERTIES VERSION ${PCILIB_VERSION})

# 生成.pc文件
# configure_file(libpci.pc.in ${CMAKE_BINARY_DIR}/libpci.pc @ONLY)


# lspci # 链接 libpci.a
add_executable(lspci ${LSPCI_SOURCES})
target_compile_options(lspci PRIVATE -g)
#add_dependencies(lspci pci)
#target_link_libraries(lspci PRIVATE libpci.a)
target_link_libraries(lspci PRIVATE ZLIB::ZLIB)
target_link_libraries(lspci PRIVATE resolv)
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(lspci PRIVATE -DDEBUG)
    target_compile_options(lspci PRIVATE -O0)
else()
    target_compile_options(lspci PRIVATE -O2)
endif()

# setpci
#add_executable(setpci setpci.c common.c)
add_executable(setpci ${SETPCI_SOURCES})
target_compile_options(setpci PRIVATE -g)
#add_dependencies(setpci pci)
#target_link_libraries(setpci PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/lib/libpci.a)
target_link_libraries(setpci PRIVATE ZLIB::ZLIB)
target_link_libraries(setpci PRIVATE resolv)
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(setpci PRIVATE -DDEBUG)
    target_compile_options(setpci PRIVATE -O0)
else()
    target_compile_options(setpci PRIVATE -O2)
endif()

# example
#add_executable(example example.c)
add_executable(example ${EXAMPLE_SOURCES})
target_compile_options(example PRIVATE -g)
#add_dependencies(example pci)
#target_link_libraries(example PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/lib/libpci.a)
target_link_libraries(example PRIVATE ZLIB::ZLIB)
target_link_libraries(example PRIVATE resolv)
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(example PRIVATE -DDEBUG)
    target_compile_options(example PRIVATE -O0)
else()
    target_compile_options(example PRIVATE -O2)
endif()
