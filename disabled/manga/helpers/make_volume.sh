# Script takes 3 parameters: volume name, first chapter, last chapter
# Order is defined lexicographically. No numbering assumed
VOLUME=$1
FIRST=$2
LAST=$3
[[ $VOLUME ]] || exit 1
[[ $FIRST ]] || exit 1
[[ $LAST ]] || exit 1
#Skipping to first
ALL=`ls -1`

# For safe debugging
MV='mv'

mkdir working

# Moving relevant files
INCLUDED=false
for file in $ALL
do 
	if [[ $file == *$FIRST* ]]; then 
		INCLUDED=true
	fi
	if [[ $INCLUDED = true ]]; then 
		$MV $file working/$file
	fi
	if [[ $file == *$LAST* ]]; then 
		INCLUDED=false
		$MV $file working/$file
	fi
done

#Unpacking and repacking
cd working

for file in `ls -1`
do
	unzip $file -d ${file/.*/}
	rm $file
done

zip -r $VOLUME.zip *
mv $VOLUME.{zip,cbz}

#Move back to original folder and cleanup
ls -1 | grep -v cbz | xargs rm -rf
cd ..
mv working/$VOLUME.cbz .
rmdir working
