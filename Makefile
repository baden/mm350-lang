.PHONY: all clean upload show

all:: target

TARGETS_ALL := $(filter-out target,$(patsubst %.Makefile,%,$(wildcard *.Makefile)))

ifneq ($(TARGET),)

TARGETS := $(TARGET)

else

TARGETS ?= $(TARGETS_ALL)

endif

targets:
	@echo "TARGETS=$(TARGETS)"

## COLORS #################

RESET       = $(shell tput sgr0)
#$(shell )
BLACK       = $(shell tput setaf 0)
BLACK_BG    = $(shell tput setab 0)
DARKGREY    = $(shell tput setaf 0; tput bold)
RED         = $(shell tput setaf 1)
RED_BG      = $(shell tput setab 1)
LIGHTRED    = $(shell tput setaf 1; tput bold)
GREEN       = $(shell tput setaf 2)
GREEN_BG    = $(shell tput setab 2)
LIME        = $(shell tput setaf 2; tput bold)
BROWN       = $(shell tput setaf 3)
BROWN_BG    = $(shell tput setab 3)
YELLOW      = $(shell tput setaf 3; tput bold)
BLUE        = $(shell tput setaf 4)
BLUE_BG     = $(shell tput setab 4)
BRIGHTBLUE  = $(shell tput setaf 4; tput bold)
PURPLE      = $(shell tput setaf 5)
PURPLE_BG   = $(shell tput setab 5)
PINK        = $(shell tput setaf 5; tput bold)
CYAN        = $(shell tput setaf 6)
CYAN_BG     = $(shell tput setab 6)
BRIGHTCYAN  = $(shell tput setaf 6; tput bold)
LIGHTGREY   = $(shell tput setaf 7)
LIGHTGREYBG = $(shell tput setab 7)
WHITE       = $(shell tput setaf 7; tput bold)

define for_all_targets
	@for target in $(TARGETS) ; do \
		echo "${GREEN_BG}:$$target${RESET}" && \
		$(MAKE) -j5 -f $$target.Makefile --no-print-directory $(1) || exit $$?; \
	done
endef

COMMANDS := target clean upload

define translate
$1::
	$$(call for_all_targets, $1)
endef

$(foreach command,$(COMMANDS),$(eval $(call translate,$(command))))

#
# use this like:
# 'make print-PATH print-CFLAGS make print-ALL_OBJS'
# to see the value of make variable PATH and CFLAGS, ALL_OBJS, etc.
#
print-%:
	@echo $* is $($*)

printto-%::
	$(call for_all_targets, print-$*)
