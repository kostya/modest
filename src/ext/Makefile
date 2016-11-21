.PHONY: package
package: ./modest-c/lib/libmodest_static.a

./modest-c:
	git clone --depth 1 https://github.com/lexborisov/Modest.git ./modest-c

./modest-c/lib/libmodest_static.a: ./modest-c
	cd modest-c && make MODEST_BUILD_SHARED=OFF MODESTS_BUILD_WITHOUT_THREADS=YES MODEST_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf modest-c
