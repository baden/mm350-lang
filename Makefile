.PHONY: all clean upload show

TARGET := mm352-00
# LANG := ru
LANG := vi_VN
SERVER=baden@het.navi.cc

BUILD_PATH := ./build/$(LANG)
# FFMPEG_GAIN_vi_VN := -af "volume=3.0"
# FFMPEG_END_PAUSE_vi_VN := -i wav/end_pause.wav
FFMPEG_FLAGS := -acodec libopencore_amrnb -ab 12.2k -ac 1 -ar 8k -y $(FFMPEG_GAIN_$(LANG))
SRVDIR=~/www/files/$(TARGET)/lang/$(LANG)/amr/

FFMPEG := ffmpeg
MKDIR := mkdir -p
MAKELIST := python ./makelist2.py

# all: amrlist.dat

# amrlist.dat: amrlist.txt Makefile makelist.py
# 	python ./makelist.py $< $@

WAV_FILES := $(filter-out %end_pause.wav, $(wildcard wav/$(LANG)/*.wav))
AMR_FILES := $(patsubst wav/$(LANG)/%,$(BUILD_PATH)/amr/%,$(WAV_FILES:wav=amr))
AMR_DAT_FILE := $(BUILD_PATH)/amr.dat

all: $(AMR_FILES) $(AMR_DAT_FILE)

show:
	@echo WAV_FILES = $(WAV_FILES)
	@echo AMR_FILES = $(AMR_FILES)
	@echo AMR_DAT = $(AMR_DAT_FILE)

$(BUILD_PATH)/amr/%.amr: wav/$(LANG)/%.wav
	@echo Convert $< to $@
	@$(MKDIR) $(dir $@)
	@$(FFMPEG) -i $< $(FFMPEG_FLAGS) $@
	# $(FFMPEG) -i $< -i wav/$(LANG)/end_pause.wav -filter_complex "aeval=val(ch)/2:c=same;concat=n=2:v=0:a=1" $(FFMPEG_FLAGS) $@

$(AMR_DAT_FILE): amrlist-$(LANG).txt Makefile makelist2.py $(AMR_FILES)
	$(MAKELIST) $< $@ $(BUILD_PATH)/amr

clean:
	@rm -f $(AMR_DAT_FILE) $(AMR_FILES)

upload: $(AMR_DAT_FILE) $(AMR_FILES)
	@echo Upload to $(SERVER):$(SRVDIR)
	@ssh $(SERVER) rm -f $(SRVDIR)/*
	@ssh $(SERVER) mkdir -p $(SRVDIR)
	@scp $(BUILD_PATH)/amr/*.amr $(BUILD_PATH)/amr.dat $(SERVER):$(SRVDIR)
	#ssh $(SERVER) ln -sf $(SRVDIR)../ $(SRVDIR)../../ua
