all: translate \
	ja/docs/book.toml
.PHONY: all

translate:
	po4a ${PO4A_OPTS} po4a.cfg
.PHONY: translate

ja/docs/book.toml: ../docs/book.toml convert-mdBook-config
	mkdir -p $(dir $@)
	./convert-mdBook-config < $< > $@
