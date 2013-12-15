shpec_quote() {
    printf "%s\n" "$1" |
    sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"
}

shpec_prefix_with() {
    sed "s/^/$1/"
}

shpec_indent_prefix() {
    for i in $(seq $(($1 - 1))); do
        printf "%s" "$SHPEC_INDENT_STRING"
    done
    echo
}

shpec_indent() {
    shpec_prefix_with "$(shpec_indent_prefix $SHPEC_LEVEL)"
}
