curl -s 'https://www.google.ru/search?client=opera&q=html+parsers&sourceid=opera&ie=UTF-8&oe=UTF-8&num=100' -A 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET4.0C)' > google.html
bundle
crystal deps
crystal build test-libxml.cr --release -o bin_test_libxml --no-debug
crystal build test-myhtml.cr --release -o bin_test_myhtml --no-debug
crystal build test-libxml2.cr --release -o bin_test_libxml2 --no-debug
crystal build test-myhtml2.cr --release -o bin_test_myhtml2 --no-debug
