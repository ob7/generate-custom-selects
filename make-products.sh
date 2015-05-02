#!/bin/bash
for list in *.products
	do
		echo "product list is $list"
	done
echo $list
i="1"
rm -rf files
mkdir files
cp $list files
cd files
#read -p "enter to continue"
for ((i=1;; i++)); do
	read "p$i" || break;
	echo "line content is $p"
	eval line="\$p$(echo $i)"
	echo "line $i:"
	echo $line 
	echo $line >line
	cat line | awk -F: '{print $1}' >product$i
	cat line | awk -F: '{print $2}' >size$i
	cat line | awk -F: '{print $3}' >paper$i
	cat line | awk -F: '{print $4}' >colors$i
	cat line | awk -F: '{print $5}' >amount$i
	cat line | awk -F: '{print $6}' >price$i
	category=$(cat product$i)
	size=$(cat size$i)
	paper=$(cat paper$i)
	colors=$(cat colors$i)
	amount=$(cat amount$i)
	price=$(cat price$i)
	echo "product is $category"
	echo "size is $size"
	echo "paper is $paper"
	echo "color is $colors"
	echo "amount is $amount"
	echo "price is $price"
	categoryDirectory=$(echo $category$(echo ".category"))
	sizeDirectory=$(echo $size$(echo ".size"))
	paperDirectory=$(echo $paper$(echo ".paper"))
	colorsDirectory=$(echo $colors$(echo ".colors"))
	amountDirectory=$(echo $amount$(echo ".amount"))
	priceDirectory=$(echo $price$(echo ".price"))	
	echo "category directory is $categoryDirectory"
	echo "size directory is $sizeDirectory"
	echo "paperDirectory is $paperDirectory"
	echo "colorsDirectory is $colorsDirectory"
	echo "amount directory is $amountDirectory"
	echo "price directory is $priceDirectory"	
	mkdir "$categoryDirectory"
	cd "$categoryDirectory"
	echo "$category" >"$category"
	mkdir "$sizeDirectory"
	cd "$sizeDirectory"
	echo "$size" >"$size"
	mkdir "$paperDirectory"
	cd "$paperDirectory"
	echo "$paper" >"$paper"
	mkdir "$colorsDirectory"
	cd "$colorsDirectory"
	echo "$colors" >"$colors"
	mkdir "$amountDirectory"
	cd "$amountDirectory"
	echo "$amount" >"$amount"
	#mkdir "$price"
	#cd "$price"
	echo "$price" >price
	#cat /opt/lampp/htdocs/priceforms-custom/priceforms-script/assets/quantityBase >quantity-base
	#sed -i "s/PRICE/$price/g" quantity-base
	#sed -i "s/QUANTITY/$amount/g" quantity-base
	#sed -i "s/THEQUANTITY/$
	#this is where you left off:
	#cat quantity-base >>quantities
	#cd ../../../../../../
	cd /opt/lampp/htdocs/priceforms-custom/priceforms-script/files/
	dir=$(pwd)
	echo "current directory is $dir"
	rm *
	#cat line$i | awk -F: '{print $'$i'}'
	#product="echo $line$(awk -F: '{print $1}')"	
	#echo "product type is $product"
	#cat $list | sed "$i,$i!d"
	#i=$[i+1]
#done <$list
done <master.products
