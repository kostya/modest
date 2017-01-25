CRYSTAL ?= crystal
CRYSTALFLAGS ?= --release

.PHONY: all package spec
all: bin_example1 bin_example2 bin_example3
package: src/ext/modest-c/lib/libmodest_static.a

libs:
		crystal deps

bin_example1: src/*.cr src/**/*.cr examples/example1.cr package
		$(CRYSTAL) build examples/example1.cr $(CRYSTALFLAGS) -o $@

bin_example2: src/*.cr src/**/*.cr examples/example2.cr package
		$(CRYSTAL) build examples/example2.cr $(CRYSTALFLAGS) -o $@

bin_example3: src/*.cr src/**/*.cr examples/example3.cr package
		$(CRYSTAL) build examples/example3.cr $(CRYSTALFLAGS) -o $@

src/ext/modest-c/lib/libmodest_static.a:
		cd src/ext && make package

spec:
		crystal spec

.PHONY: clean
clean:
		rm -f bin_* src/ext/modest-c/lib/libmodest_static.a
