# CUSTOMIZE THE FLOATING FEATURES USING AROMA INSTALLER
### A very simple shell script for add lines in floating_features.xml

It's made to use with AROMA installer, because it reads a prop file (in this case, from /tmp/aroma/fting.prop) to know if add or not the feature line
You can change it to use for your purpose!

Note: make sure to use a UNIX text file, if you use a Windows formatted one, the recovery can't read the script!. You can download the script of this repo to dont fight with that problem.

``` go
#!/sbin/sh
# Written by Gonic

floatingpath=/vendor/etc/floating_feature.xml 	# Your ROM floating file
si=1 	# the value of the prop that allows the line to be written

getProperty () {
   PROP_KEY=$1
   PROP_VALUE=`cat $PROPERTY_FILE | grep "$PROP_KEY" | cut -d'=' -f2`
   echo $PROP_VALUE
} # The getPropery function

sed -i '/^$/d' $floatingpath	# Delete blank lines
sed -i '$d' $floatingpath	# Delete the last line that ends XML

PROPERTY_FILE=/tmp/aroma/fting.prop	# File where the props are stored

prop=$(getProperty "navbar")
feature='<SEC_FLOATING_FEATURE_FRAMEWORK_CONFIG_NAVIGATION_BAR_THEME>SupportLightNavigationBar|SupportCustomBgColor|SupportNaviBarRemoteView</SEC_FLOATING_FEATURE_FRAMEWORK_CONFIG_NAVIGATION_BAR_THEME>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
fi

prop=$(getProperty "highperformance")
feature='<SEC_FLOATING_FEATURE_COMMON_SUPPORT_HIGH_PERFORMANCE_MODE>TRUE</SEC_FLOATING_FEATURE_COMMON_SUPPORT_HIGH_PERFORMANCE_MODE>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
		echo '    ' '<SEC_FLOATING_FEATURE_SYSTEM_SUPPORT_ENHANCED_CPU_RESPONSIVENESS>TRUE</SEC_FLOATING_FEATURE_SYSTEM_SUPPORT_ENHANCED_CPU_RESPONSIVENESS>' >> $floatingpath
fi

echo '</SecFloatingFeatureSet>' >> $floatingpath # Finish the XML file again
exit 0
```

