.PHONY: package
package: ./modest-c/lib/libmodest_static.a

./modest-c:
	git clone --depth 1 https://github.com/lexborisov/Modest.git ./modest-c
	# cd myhtml-c && git reset --hard 4849ceecc34b33ddd662f108cabc9d35cb08b261

./modest-c/lib/libmodest_static.a: ./modest-c
	cd modest-c && make MyHTML_BUILD_SHARED=OFF MyHTML_BUILD_WITHOUT_THREADS=YES MyHTML_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf myhtml-c
