PROJECT_NAME=hello_world
PROJECT_BSP=$(PROJECT_NAME)_bsp


.PHONY: all

all: 
	make -C $(PROJECT_NAME)/

download:
	cd $(PROJECT_NAME) && make download-elf

update:
	cd $(PROJECT_BSP)/ && ./create-this-bsp

clean:
	cd $(PROJECT_NAME) && make clean_all