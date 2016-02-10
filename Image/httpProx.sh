#!/bin/bash
#read max version for lantern.yaml
oldVersion=0
newVersion=0
lastestName="0"
for name in `ls ~/Library/Application\ Support/Lantern/`; do
	version=${name#*lantern-}
	version=${version%%.yaml*}
	if [[ $name =~ "bak" ]]; then
		echo -e "..."
	else
		let newVersion=`echo ${version} | sed "s:\.::g"`
		if [ "$newVersion" -gt "$oldVersion" ]; then
			lastestName=${name}
			let oldVersion=newVersion
		fi
	fi
done

ipaddr=`ifconfig en0 | grep "inet "|cut -f 2 -d " "`
echo -e "$ipaddr:8787"
`sed -i.bak "s/127.0.0.1/$ipaddr/g" ~/Library/Application\ Support/Lantern/${lastestName}`
