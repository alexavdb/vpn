set --global vpn_version 1.0.0

# Server information as an improvised dictionary with two values for each key
# 'AzireVPN server code' 'script argument' 'location string'
set --global _vpn_azirevpn_locations\
    'ca1' 'canada' 'Canada (Toronto)'\
    'ch1' 'switzerland' 'Switzerland (Zurich)'\
    'de-ber' 'germany' 'Germany (Berlin)'\
    'de1' 'germany2' 'Germany (Frankfurt)'\
    'dk1' 'denmark' 'Denmark (Copenhagen)'\
    'es1' 'spain' 'Spain (Madrid)'\
    'es2' 'spain2' 'Spain (Málaga)'\
    'fr1' 'france' 'France (Paris)'\
    'it1' 'italy' 'Italy (Milan)'\
    'nl1' 'netherlands' 'Netherlands (Amsterdam)'\
    'no1' 'norway' 'Norway (Oslo)'\
    'ro1' 'romania' 'Romania (Bucharest)'\
    'se1' 'sweden' 'Sweden (Stockholm)'\
    'se2' 'sweden2' 'Sweden (Gothenburg)'\
    'th1' 'thailand' 'Thailand (Phuket)'\
    'uk1' 'uk' 'UK (London)'\
    'us1' 'us' 'USA (Miami)'\
    'us2' 'us2' 'USA (Chicago)'\
    'us3' 'us3' 'USA (New York)'


# Modified from https://stackoverflow.com/a/69865337
# arg is the string to search for in locations
# init is the index where search should be started
# inc is an integer used to get the index of the element to return if a match for arg is found
function _vpn_extract_from_locations -a arg init inc
    set -l keyseq (seq $init 3 (count $_vpn_azirevpn_locations))
    # we can't simply use `contains` because it won't distinguish keys from values
    for idx in $keyseq
        if test $arg = $_vpn_azirevpn_locations[$idx]
            echo $_vpn_azirevpn_locations[(math $idx + $inc)]
            return
        end
    end
    return 1
end

function _vpn_code_to_argument -a code
    _vpn_extract_from_locations $code 1 1
end

function _vpn_code_to_string -a code
    _vpn_extract_from_locations $code 1 2
end

function _vpn_argument_to_code -a arg
    _vpn_extract_from_locations $arg 2 -1
end
