#!/bin/bash
i="0"
for product in *.categories
	do
		echo "filename is $product"
		#echo "${product}"
		i=$[$i+1]
	done
i="0"
rm allproducts
rm product-base*
rm data-base
rm data-base2
echo "using file $product to build product list"
	for ((i=1;; i++)); do
		read "p$i" || break;
		eval theProduct="\$p$(echo $i)"
		echo "product $i is $theProduct"
		productName="${theProduct// /_}"
		productName="${productName,,}"
		productName="${productName//-/_}"
		echo "product name is $productName"
		echo "product text is $theProduct"
		cat assets/productBase >product-base$i
		sed -i "s/PRODUCT/$productName/g" product-base$i
		sed -i "s/NAME/$theProduct/g" product-base$i
		cat product-base$i >>allproducts
		allProducts=$(cat allproducts)
		echo "productdata is $allProducts"	
		
	done <$product
cp assets/dataBase data-base
newData=$(cat allproducts)
echo "data to be inserted is $newData"
echo "now inserting data"
cat data-base | sed '/DATAGOESHERE/r allproducts' >data-base2
sed -i "s/DATAGOESHERE//g" data-base2
cp data-base2 price-forms/js/data.js
