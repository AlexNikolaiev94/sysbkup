#!/bin/bash

#
# This script generates a configuration file with either default
# Or user-specified values, which will be later used during the backup creation
#

# Include the utilities
source $(dirname "$0")/lib/_fmt.sh
source $(dirname "$0")/lib/_gen.sh

OS="$(cat /etc/os-release | grep '^ID=' | awk -F= '{ print $2 }')"

DEST=/opt/backup
CONFD="/etc/sysbkup.conf.d"
EXCFILE="$CONFD/exclude"


set_dir_for() {
    local -n ref=$2
    local input
    local confirm
    local _using_default_msg="${_GREEN}>${_NOCOLOR} Using default location ${_BLUE}${!2}${_NOCOLOR}."

    # Read the default path using nameref
    read -p "Enter a path to store $1.${_NEWLINE}${_YELLOW}Important!${_NOCOLOR} Use full system path. ${_BLUE}(Default: ${!2})${_GREEN} <${_NOCOLOR} " input
    
    # If empty string provided, use default value
    if [[ -z "$input" ]]; then
        input="${!2}"
    fi

    # Ask user to confirm the path
    read -p "${_NEWLINE}Storing generated $1 at ${_BLUE}${input}${_NOCOLOR}. Is this correct? ${_BLUE}(y|n|d for default)${_GREEN} <${_NOCOLOR} " confirm
    
    case $confirm in
    y|Y|yes|YES|Yes)
        # If provided path is same as the default one, display message for default path
        if [[ "$input" == "${!2}" ]]; then
            echo -e "$_using_default_msg"
        else
            echo -e "${_GREEN}>${_NOCOLOR} Path to store $1 at is set to ${_BLUE}${input}${_NOCOLOR}."
        fi
        ref="${input}"
        ;;
    n|N|no|NO|No)
        # User rejection. Ask again.
        echo -e "${_YELLOW}!${_NOCOLOR} Path to store $1 has not been set.${_NEWLINE}"
        set_dir_for "$1" "$2"
        ;;
    d|D)
        # Convenience option in case user wants back to default path
        echo -e "$_using_default_msg"
        ;;
    *)
        # An invalid option or an empty string provided. Ask again.
        echo -e "${_RED}X${_NOCOLOR} Unknown option ${_RED}${confirm}${_NOCOLOR} specified.${_NEWLINE}"
        set_dir_for "$1" "$2"
        ;;
    esac
}

gen_exclude_file() {
    local excfile="$(_gen_excfile)"

    echo -e "Generating an exclude file..."
    echo -e "It will be pre-populated with some default values."
    _draw_border_default 40 "="
    echo -e "Default exclude file generated and stored at ${_BLUE}${EXCFILE}${_NOCOLOR}"
    _draw_border_default 40 "="
    echo "$excfile" > "$EXCFILE"
}

gen_config_file() {
    local config="$(_gen_conf)"
    echo -e "Generating the configuration file..."
    _draw_border_default 40 "="
    echo -e "Default exclude file generated and stored at ${_BLUE}${CONFD}/sysbkup${_NOCOLOR}"
    _draw_border_default 40 "="
    echo "$config" > "$CONFD/sysbkup"
}

main() {
    _draw_border_green 80 "#"
    echo -e "Initiating config generation for the system backup utility"
    _draw_border_green 80 "#"

    set_dir_for "backup files" DEST
    _draw_border_blue 40 "="
    set_dir_for "configuration files" CONFD
    echo -e "Creating the configuration files directory..."
    mkdir -p "$CONFD"
    _draw_border_blue 40 "="
    gen_exclude_file
    _draw_border_default 40 "~"
    gen_config_file 
    echo -e "Creating an environmental variable containing the path to configuration..."
    echo "export SYSBKUP_CONFD=${CONFD}" >> /etc/profile
    _draw_border_green 80 "#"
    echo -e "All required configurations for sysbkup have been created!"
    echo -e "Exiting..."
    _draw_border_green 80 "#"
    exit 0
}

main