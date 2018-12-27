include constants.mk
SUBDIRS=general display fsm
MODULES=fsm

.PHONY: all clean fsm

all: fsm
	$(GHDLC) -a top.vhdl

fsm:
	list='$(SUBDIRS)'; for subdir in $$list; do \
	$(MAKE) all -C $$subdir || exit 1;\
	echo "exec make all in the $$subdir directory.";\
	done

clean:
	rm -rf wave/*.vcd *.o *-obj93.cf
