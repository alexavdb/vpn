function _vpn_print_help
    echo " Usage: vpn [location]    Turn on VPN and connect to default/specified location."
    echo "        vpn off           Turn VPN off."
    echo "        vpn ls            List supported locations and location codes."
    echo "        vpn status         Display the current connection status."
    echo "        vpn help           Display this help screen."
end

function _vpn_print_locations
    echo -e ' Currently supported locations and their corresponding argument:'

    set output ' Location===Argument\n ───────────────────────===───────────'
    set -l keyseq (seq 1 3 (count $_vpn_azirevpn_locations))
    for idx in $keyseq
        set -l loc_string $_vpn_azirevpn_locations[(math $idx + 2)]
        set -l loc_arg $_vpn_azirevpn_locations[(math $idx + 1)]
        set output (string join '' $output '\n ' $loc_string "===" $loc_arg)
    end
    echo
    echo -e "$output" | column -t -s ===
end

function _vpn_status
    #TODO: extract to function or pass as argument
    set -l current_connection (ifconfig | string match -r '^azirevpn-(?:\w|-)+' | string sub -s 10)

    if test -n "$current_connection"
        set -l loc (_vpn_code_to_string $current_connection)
        echo -e " ✅ You are connected to AzireVPN in $loc via WireGuard."
        return 0
    else
        echo -e " ❌ You are not connected to AzireVPN via WireGuard."
        return 1
    end
end

function _vpn_connect -a location
    # If no location was provided fall back to default
    if test -z "$location"
        set location 'netherlands'
    end

    set -l code (_vpn_argument_to_code $location)
    if test -n "$code"
        #TODO: extract to function or pass as argument
        set -l current_connection (ifconfig | string match -r '^azirevpn-(?:\w|-)+' | string sub -s 10)

        if test -n "$current_connection"
            set -l loc (_vpn_code_to_string $current_connection)
            echo -e " ✅ You are already connected to AzireVPN in $loc."
            _vpn_disconnect
        end

        set -l loc (_vpn_code_to_string $code)
        echo -e " 📡 Connecting to AzireVPN in $loc…"
        _vpn_wireguard_action 'up' $code
        echo " ✅ Done."
    else
        echo -e "❌ Incorrect location argument, use \"vpn ls\" to list all valid arguments."
        return 1
    end

end

function _vpn_disconnect
    #TODO: extract to function or pass as argument
    set -l current_connection (ifconfig | string match -r '^azirevpn-(?:\w|-)+' | string sub -s 10)

    if test -n "$current_connection"
        set -l loc (_vpn_code_to_string $current_connection)
        echo -e " 👋 Disconnecting from AzireVPN in $loc…"
        _vpn_wireguard_action 'down' $current_connection
    else
        echo -e " ❌ You are not connected to AzireVPN via WireGuard."
        return 1
    end

    echo " ✅ Done."
end

function _vpn_wireguard_action -a action server
    set server (string join '' "azirevpn-" $server)
    command wg-quick $action $server > /dev/null 2>&1
    # TODO: deal with errors with running wg-quick
end

function vpn --argument-names arg --description "Manage WireGuard connections for AzireVPN"
    switch "$arg"
        case help
            _vpn_print_help
        case ls
            _vpn_print_locations
        case status
            _vpn_status $current_connection
        case off
            _vpn_disconnect
        case '*'
            _vpn_connect "$arg"
    end
end
