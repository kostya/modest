CRYSTAL ?= crystal
CRYSTALFLAGS ?= --release

.PHONY: all package spec
all: bin_example
package: src/ext/modest-c/lib/libmodest_static.a

libs:
		crystal deps

bin_example: src/*.cr src/**/*.cr example.cr package
		$(CRYSTAL) build example.cr $(CRYSTALFLAGS) -o $@

src/ext/modest-c/lib/libmodest_static.a:
		cd src/ext && make package

spec:
		crystal spec

.PHONY: clean
clean:
		rm -f bin_* src/ext/modest-c/lib/libmodest_static.a
