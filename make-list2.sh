#!/bin/bash
cat got-price5.json | awk '!a[$0]++' >mlist
cat mlist | sed -n /'SHEET: Business Cards/,/*/p' >mlist2
cat mlist2 | sed 's/SHEET.*//' >mlist3
cat mlist3 | sed 's/Type.*//' >mlist2
cat mlist2 | sed 's/,,,*//' >mlist3
cat mlist3 | sed 's/,#DIV\/0!//' >mlist2
#cat mlist2 | sed 's/$,//' >mlist3
cat mlist3 | sed 's/Add*//' >mlist2
cat mlist2 | sed '/^$/d' >mlist3
cat mlist3 | sed 's/.*Windowed Envelops//' >mlist2
cat mlist2 | sed 's/$-//' >mlist3
cat mlist3 | sed 's/,Size.*//' >mlist2
cat mlist2 | sed 's/#DIV.*//' >mlist3
cat mlist3 | sed 's/#REF.*//' >mlist2
cat mlist2 | sed '/^$/d' >mlist3
sed -i "s/Business Card /Business Card/g" mlist3
sed -i "s/Letter Head /Letter Head/g" mlist3
sed -i "s/Door Hangers /Door Hangers/g" mlist3
sed -i "s/Banner /Banner/g" mlist3
