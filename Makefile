WIDTH = 600

BASE = captioned-image--badass-fluttershy--terminator-liberation
SVG = $(BASE).svg
DESTBASE = $(BASE)-$(WIDTH)
PNG = $(DESTBASE).png
JPEG = $(DESTBASE).jpg
WEBP = $(DESTBASE).webp

THIRD_PERSON_SVG = gotta-be-a-badass-to-play-one--3rd-tense.svg
THIRD_PERSON_PNG = $(THIRD_PERSON_SVG).png
THIRD_PERSON_JPEG = $(THIRD_PERSON_SVG).jpg
THIRD_PERSON_WEBP = $(THIRD_PERSON_SVG).webp

NOBRANDING_PERSON_SVG = gotta-be-a-badass-to-play-one--3rd-tense--wo-hashtag-and-username.svg
NOBRANDING_PERSON_PNG = $(NOBRANDING_PERSON_SVG).png
NOBRANDING_PERSON_JPEG = $(NOBRANDING_PERSON_SVG).jpg
NOBRANDING_PERSON_WEBP = $(NOBRANDING_PERSON_SVG).webp

PHOTO_DEST = d5gxovp-14e90c16-410d-4433-b1ba-c7af00bb53cb.png

all: $(PNG) $(JPEG) $(WEBP)
# all: $(NOBRANDING_PERSON_PNG) $(NOBRANDING_PERSON_WEBP) $(NOBRANDING_PERSON_JPEG) $(NOBRANDING_PERSON_PNG)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-filename=$@ --export-width=$(WIDTH) $<
	optipng $@

$(WEBP): $(PNG)
	gm convert $< $@

$(JPEG): $(PNG)
	gm convert $< $@

$(THIRD_PERSON_PNG): $(THIRD_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-filename=$@ --export-width=$(WIDTH) $<
	optipng $@

$(THIRD_PERSON_WEBP): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(THIRD_PERSON_JPEG): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_PNG): $(NOBRANDING_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-filename=$@ --export-width=$(WIDTH) $<
	optipng $@

$(NOBRANDING_PERSON_WEBP): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_JPEG): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(PHOTO_INTERIM1): $(PHOTO_BASE).jpg
	gm convert -crop 2560x1177 $< $@


clean:
	rm -f emma-*.png emma-*.jpg emma-*.webp

upload: all
	sky -x up $(WEBP)

# upload: all
#	rsync --progress -v -a --inplace human-hacking-field-guide-logo.svg hhfg-ad.svg hhfg-ad.svg.png $(__HOMEPAGE_REMOTE_PATH)/hhfg-graphics-demo/
