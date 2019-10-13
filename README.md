# elastic-searcher
Searches shodan for open elastic search servers and check for interesting things

# NOTE: This may be illegal to run in your country! Please check your local laws first, i'm not responsible for your running this script!
# This is NOT a subtle script. You have been warned.

## Requirements
* You'll need to install elasticdump and shodan CLI first.
* You'll need to configure shodan with an API key

## Usage
./elasticsearcher.sh
* Shodan results are limited to the first 1000 entries, you can change this by editting line 24

## Features
* Looks for Credit Card information :(
* Looks for passwords :(
* Looks for email addresses :(
