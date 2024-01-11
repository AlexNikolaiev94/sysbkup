_NOCOLOR=$'\e[0m'
_GREEN=$'\e[38;5;82m'
_BLUE=$'\e[36m'
_YELLOW=$'\e[1;33m'
_RED=$'\e[0;31m'
_NEWLINE=$'\n'

_repeat_char() {
    for i in $(eval echo "{1..$1}"); do echo -n "$2"; done 
}

_draw_border_green() {
    echo -e "${_NEWLINE}${_GREEN}$(_repeat_char "$1" "$2")${_NOCOLOR}${_NEWLINE}"
}

_draw_border_blue() {
    echo -e "${_NEWLINE}${_BLUE}$(_repeat_char "$1" "$2")${_NOCOLOR}${_NEWLINE}"
}

_draw_border_default() {
    echo -e "${_NEWLINE}${_NOCOLOR}$(_repeat_char "$1" "$2")${_NOCOLOR}${_NEWLINE}"
}