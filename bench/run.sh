echo "============= Parsing =================="
echo "Nokogiri(LibXML)"
./xtime.rb ruby test-libxml.rb
echo "Crystagiri(LibXML)"
./xtime.rb ./bin_test_libxml
echo "modest(myhtml)"
./xtime.rb ./bin_test_myhtml

echo "============= Selectors =================="
echo "Nokogiri(LibXML)"
./xtime.rb ruby test-libxml2.rb
echo "Crystagiri(LibXML)"
./xtime.rb ./bin_test_libxml2
echo "modest(myhtml)"
./xtime.rb ./bin_test_myhtml2
