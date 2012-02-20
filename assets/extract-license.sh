#!/bin/sh
EMPTY=""
for i in $* ; do
	COMMENT=`exiv2 -q -Pt -g Exif.Photo.UserComment $i`
	if [ -n "$COMMENT" ] ; then
		LINK=`echo $COMMENT | sed "s/^.*Source: \([^ ]*\).*$/\1/"`
		LICENSE=`echo $COMMENT | sed "s/^.*License: \([^ ]*\).*$/\1/"`
		LICENSE=`echo $LICENSE | sed "s/Attribution/BY/;s/NonCommercial/NC/;s/ShareAlike/SA/;s/NoDerivs/ND/"`
		echo "<li><a href=\"$LINK\">$LINK</a> CC $LICENSE</li>"
	else
		EMPTY="$i $EMPTY"
	fi
done
if [ -n "$EMPTY" ] ; then
	echo "Please check manually: $EMPTY" >&2
fi

