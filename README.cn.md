
# 当前分支主要目的
	支持win10 vs2022环境单步debug
 	方便通过单步debug熟悉pci相关的底层源码细节

# linux 调试环境
	centos7.9
 	gcc 10.2.1
  	cmake 3.26.4
   	gdb 9.2

# CMakeLists.txt 的生成方式
	手动编辑
 	基于./Makefile ./lib/Makefile ./lib/config.mk等文件

# lspci链接libpci.a的处理方式
	直接将libpci.a相关的c文件全部加到lspci等程序中
 	避免跨库debug不方便的问题

# lib/config.mk 等文件的来源
   	实际需要先执行make，然后./lib/config.mk 也是一个编译参考项。
   	不同调试环境，可参考此部重新编辑CMakeLists.txt文件。

# pciutils的实际版本
	3.5.1
 	因为centos7下
  	$ rpm -qa | grep pciutils
	pciutils-libs-3.5.1-3.el7.x86_64
	pciutils-3.5.1-3.el7.x86_64

 	其他版本pciutils可参照当前版本CMakeLists.txt的生成方式进行编辑。


# 原编译方式
	直接在src目录执行make即可

# 编译后的几个程序
	
## lspci

## setpci

## update-pciids



