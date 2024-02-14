PROJECT_NAME=hello_world
PROJECT_BSP=$(PROJECT_NAME)_bsp


.PHONY: all clean download update test d2u

all: 
	make -C $(PROJECT_NAME)/

download:
	cd $(PROJECT_NAME) && make download-elf

update: d2u
	cd $(PROJECT_BSP)/ && ./create-this-bsp

clean:
	cd $(PROJECT_NAME) && make clean

clean_bsp:
		cd $(PROJECT_BSP) && make clean

clean_all:
	cd $(PROJECT_NAME) && make clean_all

test: tests.py
	python tests.py

d2u:
	dos2unix $(PROJECT_BSP)/create-this-bsp
