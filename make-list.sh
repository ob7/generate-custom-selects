#!/bin/bash
# cat got-price prints out entire starting file, sed -n then extracts only text from SHEET: Mas...to next occurance of SHEET
echo "Loading database..."
echo "Extracting Master List"
#cat got-price2.json | sed -n /'SHEET: Master List/,/SHEET/p' >master-list

#since the above command grabbed from SHEET until the next SHEET, I want to remove last line since its only there because I used it when extracting the info we first wanted.
# the first part of sed says skip first occurance, the second part says replace SHEET and rest of line with nothing
#echo "Removing last occurance of SHEET header"
#cat master-list | sed '0,/SHEET/! s/SHEET.*//' >master-list2
#remove empty lines from file
#cat master-list2 | sed '/^$/d' >master-list
#remove top line reading SHEET: Master List and white space
#cat master-list | sed 's/SHEET.*//' >master-list2
#cat master-list2 | sed '/^$/d' >master-list
#sed -i '1d' master-list

#we not have just the info we need to start with, next we need to remove data of columns that we wont be using, such as extra prices, we only need final price.
#replace all , with : but first remove all semi colons within quotes so we dont get extra tables made
#cat master-list | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", " ", $i) } 1' >master-list3
cat mlist3 | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", " ", $i) } 1' >master-list3
cat master-list3 | sed 's/,/:/g' >master-list2
echo "Starting"
#read -p "Enter to continue"
rm master-products
while read p
do
echo "begin line"
echo $p
echo "col1"
echo $p | awk -F: '{print $1}' >col1
sed -e "s/$/:/" col1 >col1a
#mv col1a col1
echo "col2"
echo $p | awk -F: '{print $2}' >col2
sed -e "s/$/:/" col2 >col2a
#mv col2a col2
echo "col3"
echo $p | awk -F: '{print $3}' >col3
sed -e "s/$/:/" col3 >col3a
#mv col3a col3
echo "col4"
echo $p | awk -F: '{print $4}' >col4
sed -e "s/$/:/" col4 >col4a
#mv col4a col4
echo "col5"
echo $p | awk -F: '{print $5}' >col5
sed -e "s/$/:/" col5 >col5a
#mv col5a col5
echo "col6"
echo $p | awk -F: '{print $6}' >col6
#cat master-list2 | awk -F: '{print $7}'
#cat master-list2 | awk -F: '{print $8}'
#cat master-list2 | awk -F: '{print $9}'
#cat master-list2 | awk -F: '{print $10}'
#cat master-list2 | awk -F: '{print $11}'
#cat master-list2 | awk -F: '{print $12}'
#echo $p | awk -F: '{print $13}' >col6
sed -e "s/$/:/" col6 >col6a
#mv col6a col6
#cat master-list2 | awk -F: '{print $14}'
echo $(cat col1a col2a col3a col4a col5a col6a) >product
#echo "product is"
cat product >>master-products
echo "It Was Read"
done < master-list2
echo "Master List Generated"
#read -p "Press any key to generator selectors"
#cat master-list2 | sed 's/,/:/g' | awk -F: '{print $2}' | sed "s/$/:/g"

#now remove duplicate lines
#sort master-products | uniq >master-product-list


#now generate category list - this shows only product types
cat master-products | sed 's/:.*//g' >categories
awk '!x[$0]++' categories  >product-categories
cp product-categories product.categories
cp master-products master.products
sed -i '/^$/d' product.categories
sed -i 's/ *$//' product.categories
awk '!a[$0]++' product.categories >p1
mv p1 product.categories
