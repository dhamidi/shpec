color_green() {
    printf "32\n"
}

color_red() {
    printf "31\n"
}

color_yellow() {
    printf "33\n"
}

color_blue() {
    printf "34\n"
}

color_magenta() {
    printf "35\n"
}

color_cyan() {
    printf "36\n"
}

color_cyan() {
    printf "37\n"
}

color() {
    printf "\033[%s;1m%s\033[0m" $(color_$1) "$2"

}
