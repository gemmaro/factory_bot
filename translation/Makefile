all: translate \
	ja/docs/book.toml
.PHONY: all

translate:
	LANG=C po4a ${PO4A_OPTS} po4a.cfg
.PHONY: translate

ja/docs/book.toml: ../docs/book.toml convert-mdBook-config
	mkdir -p $(dir $@)
	./convert-mdBook-config < $< > $@
