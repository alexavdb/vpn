set --global vpn_version 1.2.0

set _vpn_code_prefix 'azirevpn'

# Server information as an improvised dictionary with two values for each key
# 'AzireVPN server code' 'script argument' 'location string'
set --global _vpn_azirevpn_locations\
    "$_vpn_code_prefix-ca1" "canada" "Canada (Toronto)"\
    "$_vpn_code_prefix-ch1" "switzerland" "Switzerland (Zurich)"\
    "$_vpn_code_prefix-de-ber" "germany" "Germany (Berlin)"\
    "$_vpn_code_prefix-de1" "germany2" "Germany (Frankfurt)"\
    "$_vpn_code_prefix-dk1" "denmark" "Denmark (Copenhagen)"\
    "$_vpn_code_prefix-es1" "spain" "Spain (Madrid)"\
    "$_vpn_code_prefix-es2" "spain2" "Spain (Málaga)"\
    "$_vpn_code_prefix-fr1" "france" "France (Paris)"\
    "$_vpn_code_prefix-it1" "italy" "Italy (Milan)"\
    "$_vpn_code_prefix-nl1" "netherlands" "Netherlands (Amsterdam)"\
    "$_vpn_code_prefix-no1" "norway" "Norway (Oslo)"\
    "$_vpn_code_prefix-ro1" "romania" "Romania (Bucharest)"\
    "$_vpn_code_prefix-se1" "sweden" "Sweden (Stockholm)"\
    "$_vpn_code_prefix-se2" "sweden2" "Sweden (Gothenburg)"\
    "$_vpn_code_prefix-th1" "thailand" "Thailand (Phuket)"\
    "$_vpn_code_prefix-uk1" "uk" "UK (London)"\
    "$_vpn_code_prefix-us1" "us" "USA (Miami)"\
    "$_vpn_code_prefix-us2" "us2" "USA (Chicago)"\
    "$_vpn_code_prefix-us3" "us3" "USA (New York)"

# Modified from https://stackoverflow.com/a/69865337
# arg is the string to search for in locations
# init is the index where search should be started
# inc is an integer used to get the index of the element to return if a match for arg is found
function _vpn_extract_from_locations --argument-names arg init inc
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

function _vpn_code_to_string --argument-names code
    _vpn_extract_from_locations $code 1 2
end

function _vpn_argument_to_code --argument-names arg
    _vpn_extract_from_locations $arg 2 -1
end
