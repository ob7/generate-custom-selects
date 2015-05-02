#!/bin/bash
cd files
echo "destroying original files..."
rm category.output
find . -name "sizes.output" -exec rm {} \;
find . -name "paper.output" -exec rm {} \;
find . -name "color.output" -exec rm {} \;
find . -name "amount.output" -exec rm {} \;
cp ../assets/template itemTemplate
cp ../assets/dataBase dataObjectFoundation
i="1"
ia="1"
ib="1"
ic="1"
id="0"
for category in *.category; do
	echo "file is $category"
	echo "number is $i"
	cd "$category"
	categoryName=${category%.*}
	lowerCaseName=${categoryName,,}
	upperCaseName=${categoryName^^}
	normalCaseName=${categoryName,,}
	normalCaseName2=$(echo $normalCaseName | sed "s/\b\(.\)/\u\1/g")
	templateName=$(echo $categoryName$(echo ".template"))
	uniqueIdentifier=$(echo "category"$(echo $i))
	defaultText="Select Paper Size"
	echo "upper case title is $upperCaseName"
	cp ../itemTemplate "$templateName"
	echo "unique identifier is $uniqueIdentifier"
	sed -i "s/UNIQUE_IDENTIFIER/$uniqueIdentifier/g" "$templateName"
	sed -i "s/defaultText/$defaultText/g" "$templateName"
	sed -i "s/lowerCaseName/$lowerCaseName/g" "$templateName"
	#sed -i "s/upperCaseName/$upperCaseName/g" "$templateName"
	sed -i "s/upperCaseName/$normalCaseName2/g" "$templateName"
	sed -i "s/INSERTVALUES/INSERTSIZEVALUES/g" "$templateName"
	cat "$templateName" >> ../category.output
	for size in *.size; do
		echo "size is $size"
		cd "$size"
		sizeName=${size%.*}
		sizeLowerCaseName=${sizeName,,}
		sizeUpperCaseName=${sizeName^^}
		sizeTemplateName=$(echo $sizeName$(echo ".template"))
		sizeIdentifier=$(echo "size"$(echo $ia))
		defaultText="Select Paper"
		echo "unique identifier is $sizeIdentifier"
		cp ../../itemTemplate "$sizeTemplateName"
		sed -i "s/UNIQUE_IDENTIFIER/$sizeIdentifier/g" "$sizeTemplateName"
		sed -i "s/lowerCaseName/$sizeLowerCaseName/g" "$sizeTemplateName"
		#sed -i "s/upperCaseName/$sizeUpperCaseName/g" "$sizeTemplateName"
		sed -i "s/upperCaseName/$sizeName/g" "$sizeTemplateName"
		sed -i "s/defaultText/$defaultText/g" "$sizeTemplateName"
		sed -i "s/INSERTVALUES/INSERTPAPERVALUES/g" "$sizeTemplateName"
		cat "$sizeTemplateName" >> ../sizes.output
		for paper in *.paper; do
			echo "paper is $paper"
			cd "$paper"
			paperName=${paper%.*}
			paperLowerCaseName=${paperName,,}
			paperUpperCaseName=${paperName^^}
			paperTemplateName=$(echo $paperName$(echo ".template"))
			paperIdentifier=$(echo "paper"$(echo $ib))
			defaultText="Select Color"
			echo "unique identifier is $paperIdentifier"
			cp ../../../itemTemplate "$paperTemplateName"
			sed -i "s/UNIQUE_IDENTIFIER/$paperIdentifier/g" "$paperTemplateName"
			sed -i "s/lowerCaseName/$paperLowerCaseName/g" "$paperTemplateName"
			#sed -i "s/upperCaseName/$paperUpperCaseName/g" "$paperTemplateName"
			sed -i "s/upperCaseName/$paperName/g" "$paperTemplateName"
			sed -i "s/defaultText/$defaultText/g" "$paperTemplateName"
			sed -i "s/INSERTVALUES/INSERTCOLORVALUES/g" "$paperTemplateName"
			cat "$paperTemplateName" >> ../paper.output
			for colors in *.colors; do
				echo "color is $colors"
				cd "$colors"
				colorName=${colors%.*}
				colorNameDelux=$(echo "$colorName" | sed 's/&/\\&/g')
				colorLowerCaseName=${colorNameDelux,,}
				colorUpperCaseName=${colorNameDelux^^}
				colorTemplateName=$(echo $colorName$(echo ".template"))
				colorIdentifier=$(echo "color"$(echo $ic))
				defaultText="Select Quantity"
				echo "unique identifier is $colorIdentifier"
				echo "color name is $colorName"
				echo "upper case color name is $colorUpperCaseName"
				#read -p "press enter to continue"
				cp ../../../../itemTemplate "$colorTemplateName"
				sed -i "s/UNIQUE_IDENTIFIER/$colorIdentifier/g" "$colorTemplateName"
				sed -i "s/lowerCaseName/$colorLowerCaseName/g" "$colorTemplateName"
				#sed -i "s/upperCaseName/$colorUpperCaseName/g" "$colorTemplateName"
				sed -i "s/upperCaseName/$colorNameDelux/g" "$colorTemplateName"
				sed -i "s/defaultText/$defaultText/g" "$colorTemplateName"
				sed -i "s/INSERTVALUES/INSERTQUANTITIES/g" "$colorTemplateName"
				cat "$colorTemplateName" >> ../color.output
				for amount in *.amount; do
					echo "amount is $amount"
					cd "$amount"
					amountName=${amount%.*}
					amountLowerCaseName=${amountName,,}
					amountUpperCaseName=${amountName^^}
					amountTemplateName=$(echo $amountName$(echo ".template"))
					amountIdentifier=$(echo "amount"$(echo $id))
					sed -i 's/\$//g' price
					sed -i 's/^[ \t]*//' price
					sed -i 's/^/\$/' price
					price=$(cat price)
					echo "price is $price"
					defaultText="$price"
					cp ../../../../../itemTemplate "$amountTemplateName"
					sed -i "s/UNIQUE_IDENTIFIER/$amountIdentifier/g" "$amountTemplateName"
					sed -i "s/lowerCaseName/$amountLowerCaseName/g" "$amountTemplateName"
					#sed -i "s/upperCaseName/$amountUpperCaseName/g" "$amountTemplateName"
					sed -i "s/upperCaseName/$amountName/g" "$amountTemplateName"
					sed -i "s/defaultText/$defaultText/g" "$amountTemplateName"
					cat "$amountTemplateName" >> ../amount.output
					cd ..
					id=$[id+1]
				done
				ic=$[ic+1]
				cat ../color.output | sed '/INSERTQUANTITIES/r amount.output' >newOutput
				sed -i "s/INSERTQUANTITIES//g" newOutput
				mv newOutput ../color.output
				cd ..
			done
			ib=$[ib+1]
			cat ../paper.output | sed '/INSERTCOLORVALUES/r color.output' >newOutput
			sed -i "s/INSERTCOLORVALUES//g" newOutput
			mv newOutput ../paper.output
			cd ..
		done
		ia=$[ia+1]
		currentDirectory=$(pwd)
		#read -p "current directory is $currentDirectory"
		cat ../sizes.output | sed '/INSERTPAPERVALUES/r paper.output' >newOutput
		sed -i "s/INSERTPAPERVALUES//g" newOutput
		mv newOutput ../sizes.output
		cd ..
	done
	i=$[i+1]
	cat ../category.output | sed '/INSERTSIZEVALUES/r sizes.output' >newOutput
	sed -i "s/INSERTSIZEVALUES//g" newOutput
	mv newOutput ../category.output
	cd ..
done
cat dataObjectFoundation | sed '/DATAGOESHERE/r category.output' >data-object
sed -i "s/DATAGOESHERE//g" data-object
sed -i "s/INSERTVALUES//g" data-object
cp data-object ../price-forms/js/data.js
