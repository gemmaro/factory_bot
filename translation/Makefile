export LANG=C

po4a_options = --keep-translations ${PO4A_OPTS}

all: translate \
	ja/docs/book.toml
.PHONY: all

translate:
	po4a ${po4a_options} po4a.cfg
.PHONY: translate

ja/docs/book.toml: ../docs/book.toml convert-mdBook-config
	mkdir -p $(dir $@)
	./convert-mdBook-config < $< > $@
