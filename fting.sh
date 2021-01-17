#!/sbin/sh
# Written by Gonic

PROPERTY_FILE=/vendor/fting.prop 				# File where the props are stored
floatingpath=/vendor/etc/floating_feature.xml 	# Your ROM floating file
si=1 											# the value of the prop that allows the line to be written

getProperty () {
   PROP_KEY=$1
   PROP_VALUE=`cat $PROPERTY_FILE | grep "$PROP_KEY" | cut -d'=' -f2`
   echo $PROP_VALUE
}

sed -i '/^$/d' $floatingpath	# Delete blank lines 
sed -i '$d' $floatingpath		# Delete the last line that ends XML

prop=$(getProperty "highperformance")
feature='<SEC_FLOATING_FEATURE_WLAN_SUPPORT_SECURE_WIFI>FALSE</SEC_FLOATING_FEATURE_WLAN_SUPPORT_SECURE_WIFI>'

if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
fi

echo '</SecFloatingFeatureSet>' >> $floatingpath # Finish the XML file again
exit 0
