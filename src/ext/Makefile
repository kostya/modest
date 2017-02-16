.PHONY: package
package: ./modest-c/lib/libmodest_static.a

./modest-c:
	git clone https://github.com/lexborisov/Modest.git ./modest-c
	cd modest-c && git reset --hard 017d81936f55ff677e5ba76372bd57789fddd351

./modest-c/lib/libmodest_static.a: ./modest-c
	cd modest-c && make create shared static MODEST_BUILD_SHARED=OFF MODESTS_BUILD_WITHOUT_THREADS=YES MODEST_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf modest-c
