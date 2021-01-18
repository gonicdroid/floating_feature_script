# CUSTOMIZE THE FLOATING FEATURES USING AROMA INSTALLER
### A very simple shell script for add lines in floating_features.xml

It's made to use with AROMA installer, because it reads a prop file to know if add or not the feature line
You can change it to use for your purpose!

Note: make sure to use a UNIX text file, if you use a Windows formatted one, the recovery can't read the script!. You can download the script of this repo to dont fight with that problem.

```
#!/sbin/sh
# Written by Gonic

floatingpath=/vendor/etc/floating_feature.xml 	# Your ROM floating file
si=1 											# the value of the prop that allows the line to be written

getProperty () {
   PROP_KEY=$1
   PROP_VALUE=`cat $PROPERTY_FILE | grep "$PROP_KEY" | cut -d'=' -f2`
   echo $PROP_VALUE
}

sed -i '/^$/d' $floatingpath	# Delete blank lines 
sed -i '$d' $floatingpath		# Delete the last line that ends XML

PROPERTY_FILE=/vendor/fting.prop	# File where the props are stored

prop=$(getProperty "navbar")
feature='<SEC_FLOATING_FEATURE_FRAMEWORK_CONFIG_NAVIGATION_BAR_THEME>SupportLightNavigationBar|SupportCustomBgColor|SupportNaviBarRemoteView</SEC_FLOATING_FEATURE_FRAMEWORK_CONFIG_NAVIGATION_BAR_THEME>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
fi

PROPERTY_FILE=/vendor/device.prop
prop=$(getProperty "brillo")
feature='<SEC_FLOATING_FEATURE_LCD_CONFIG_CONTROL_AUTO_BRIGHTNESS>3</SEC_FLOATING_FEATURE_LCD_CONFIG_CONTROL_AUTO_BRIGHTNESS>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
	else
		echo '    ' '<SEC_FLOATING_FEATURE_LCD_CONFIG_CONTROL_AUTO_BRIGHTNESS>0</SEC_FLOATING_FEATURE_LCD_CONFIG_CONTROL_AUTO_BRIGHTNESS>' >> $floatingpath
fi

PROPERTY_FILE=/vendor/device.prop
prop=$(getProperty "brillo")
feature='<SEC_FLOATING_FEATURE_SETTINGS_SUPPORT_AUTO_BRIGTNESS>TRUE</SEC_FLOATING_FEATURE_SETTINGS_SUPPORT_AUTO_BRIGTNESS>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
	else
		echo '    ' '<SEC_FLOATING_FEATURE_SETTINGS_SUPPORT_AUTO_BRIGTNESS>FALSE</SEC_FLOATING_FEATURE_SETTINGS_SUPPORT_AUTO_BRIGTNESS>' >> $floatingpath
fi

PROPERTY_FILE=/vendor/device.prop
prop=$(getProperty "169")
feature='<SEC_FLOATING_FEATURE_SYSTEMUI_CONFIG_CORNER_ROUND>3.5</SEC_FLOATING_FEATURE_SYSTEMUI_CONFIG_CORNER_ROUND>'
if [ $prop = $si ];
	then
		echo '    ' $feature >> $floatingpath
	else
		echo '    ' '<SEC_FLOATING_FEATURE_SYSTEMUI_CONFIG_CORNER_ROUND>1</SEC_FLOATING_FEATURE_SYSTEMUI_CONFIG_CORNER_ROUND>' >> $floatingpath
fi

PROPERTY_FILE=/vendor/fting.prop

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

#####Example:
``` go
// create functions that runs the echo, grep, and wc shell commands
echo := sh.Cmd("echo")
grep := sh.Cmd("grep")
wc := sh.Cmd("wc")
	
// run echo, pipe the output through grep and then through wc
// effectively the same as
// $ echo Hi there! | grep -o Hi | wc -w
fmt.Print(sh.Pipe(echo("Hi there!"), grep("-o", "Hi"), wc("-w")))
```	
#####Output:
```
1
```
