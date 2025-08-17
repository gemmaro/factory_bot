export LANG=C

po4a_options = --keep-translations ${PO4A_OPTS}

all: translate \
	ja/docs/book.toml
.PHONY: all

translate:
	po4a ${po4a_options} po4a.cfg
.PHONY: translate

update:
	cd ../docs && MDBOOK_OUTPUT='{"xgettext": {}}' mdbook build -d po
	msgmerge --update ../docs/po/ja.po ../docs/po/messages.pot
.PHONY: update

render:
	cd ../docs && MDBOOK_BOOK__LANGUAGE=ja mdbook build -d book/ja
.PHONY: render

ja/docs/book.toml: ../docs/book.toml convert-mdBook-config
	mkdir -p $(dir $@)
	./convert-mdBook-config < $< > $@
