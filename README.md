# vpn

An elegant command-line interface for [AzireVPN](https://www.azirevpn.com/)βs WireGuard service for the [Fish shell](https://fishshell.com/).

![Screenshot](screenshot.png)

## Install

### Fisher

[Fisher](https://github.com/jorgebucaran/fisher) can be used to install the plugin directly from the [Github mirror repository](https://github.com/alexavdb/vpn).

```console
fisher install alexavdb/vpn 
```

Alternatively, clone this repository and use Fisher to install from the local directory.

```console
fisher install ~/path/to/cloned/repository/vpn
```

### Manual

Clone this repository and copy the files in the `conf.d` and `functions` folders to the respective folders in your `$__fish_config_dir`.

## Usage

### Connect to the default server

```sh
β― vpn
```

Sample output:

```
 π‘ Connecting to AzireVPN in Netherlands (Amsterdam)...
 β Done.
```

### Connect to a specific server

```sh
β― vpn germany
```

Sample output:

```
 β You are already connected to AzireVPN in Netherlands (Amsterdam) via WireGuard.
 π Disconnecting from AzireVPN in Netherlands (Amsterdam)...
 β Done.
 π‘ Connecting to AzireVPN inGermany (Berlin)...
 β Done.
```

### Get list of currently supported servers

```sh
β― vpn ls
```

Sample output:

```
 Currently supported locations and their corresponding argument:

 Location                     Argument
 ----------------------       -----------
 Canada (Toronto)             canada
 Switzerland (Zurich)         switzerland
 Germany (Berlin)             germany
 Germany (Frankfurt)          germany2
 Denmark (Copenhagen)         denmark
 Spain (Madrid)               spain
 Spain (MΓ‘laga)               spain2
 France (Paris)               france
 Italy (Milan)                italy
 Netherlands (Amsterdam)      netherlands
 Norway (Oslo)                norway
 Romania (Bucharest)          romania
 Sweden (Stockholm)           sweden
 Sweden (Gothenburg)          sweden2
 Thailand (Phuket)            thailand
 UK (London)                  uk
 USA (Miami)                  us
 USA (Chicago)                us2
 USA (New York)               us3
```

### Disconnect

```sh
β― vpn off
```

Sample output:

```
 π Disconnecting from AzireVPN in Germany (Berlin)...
 β Done.
```

### Get connection status

```sh
β― vpn status
```

Sample output:

```
 β You are connected to AzireVPN in Netherlands (Amsterdam) via WireGuard.
```

```
 β You are not connected to AzireVPN via WireGuard.
```

## Contribute

This plugin is maintained on [Gitlab](https://gitlab.com/alexavdb/vpn), the [GitHub mirror](https://github.com/alexavdb/vpn) is merely used to allow installation using Fisher.

## Acknowledgements

This is a Fish shell alternative inspired by [Aral Balkan's original application](https://source.small-tech.org/aral/vpn).

## Disclaimer

I am not affiliated with AzireVPN and this plugin is not endorsed by AzireVPN in any way.

## License

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.html)
