
# 当前分支主要目的
	支持win10 vs2022环境单步debug

# linux 调试环境
	centos7.9
 	gcc 10.2.1
  	cmake 3.26.4
   	gdb 9.2

# CMakeLists.txt 的生成方式
	手动编辑
 	基于./Makefile ./lib/Makefile ./lib/config.mk等文件

# lib/config.mk 等文件的来源
   	实际需要先执行make，然后./lib/config.mk 也是一个编译参考项。
   	不同调试环境，可参考此部重新编辑CMakeLists.txt文件。

# 原编译方式
	直接在src目录执行make即可

# 编译后的几个程序
	
## lspci

## setpci

## update-pciids



