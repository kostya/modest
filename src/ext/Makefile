FILENAME := b00f9e4a890e928c61d2357dceb58bc54612d236.tar.gz

.PHONY: package
package: ./modest-c/lib/libmodest_static.a

./modest-c:
	# git clone https://github.com/lexborisov/Modest.git ./modest-c
	# cd modest-c && git reset --hard 558280102442c7b154935bb8b5c579dae7671580
	rm -rf ./modest-c
	wget https://github.com/lexborisov/Modest/archive/$(FILENAME)
	mkdir -p modest-c
	tar -xzf $(FILENAME) -C modest-c --strip-components 1
	rm ./$(FILENAME)


./modest-c/lib/libmodest_static.a: ./modest-c
	cd modest-c && make create shared static MODEST_BUILD_SHARED=OFF MODESTS_BUILD_WITHOUT_THREADS=YES # MODEST_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf modest-c
