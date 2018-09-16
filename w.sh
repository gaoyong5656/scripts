#!/bin/sh


get_domain_name()
{
	s=`echo $1 | cut -d : -f 2`
	echo ${s:2}
}

trim_prefix()
{
	echo `echo "$1" | sed 's/^[\t]*//'g`
}

get_property_name()
{
	echo `echo "$1" | cut -d : -f 1 `
}

get_property_value()
{
	echo `echo "$1" | cut -d ' ' -f 2 `
}

echo "this is a test";

result=`cat result | grep -e '^[^-]'`;
prefix='weblogic'
index=-1;
echo "$result" | while read line 
do
	line=$(trim_prefix "$line")
	if [[ $line = MBeanName* ]]; then
		index=$[$index+1]
		echo "$prefix.$index.domain_name="`get_domain_name "$line"`
		
	else
		echo "$prefix.$index."`get_property_name "$line"`"="`get_property_value "$line"`
	fi

done 

