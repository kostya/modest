.PHONY: package
package: ./modest-c/lib/libmodest_static.a

./modest-c:
	git clone https://github.com/lexborisov/Modest.git ./modest-c
	cd modest-c && git reset --hard 558280102442c7b154935bb8b5c579dae7671580

./modest-c/lib/libmodest_static.a: ./modest-c
	cd modest-c && make create shared static MODEST_BUILD_SHARED=OFF MODESTS_BUILD_WITHOUT_THREADS=YES MODEST_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf modest-c
