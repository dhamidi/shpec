describe() {
    shpec_push_block describe
    printf "%s\n" "$1" | shpec_indent
}

it() {
    shpec_push_block it
    shpec_var INFO_LABEL "$1"
}

info() {
    [ -z "$(shpec_var INFO_LABEL)" ] && return 0
    case "$1" in
        failure)
            color red "$(shpec_var INFO_LABEL)"
            (
                FAILURE_MESSAGE="$(shpec_var FAILURE_MESSAGE)"
                [ -n "$FAILURE_MESSAGE" ] && printf "\n%s" "$(shpec_indent $FAILURE_MESSAGE)"
            )
            ;;
        success)
            color green "$(shpec_var INFO_LABEL)"
            ;;
    esac | shpec_indent
    printf "\n"
}

expect() {
    if ! expr "$1" $3 "$4" >/dev/null ; then
        SHPEC_TMP_BUFFER=$({
            printf "Comparison failed (using %s):\n" "$3"
            printf "Expected:\n"
            printf " %s\n" "$4"
            printf "Got:\n"
            printf " %s\n" "$1"
        })
        shpec_var FAILURE_MESSAGE "$SHPEC_TMP_BUFFER"

        return 1
    else
        return 0
    fi
}

end() {
    RETVAL=$?
    if [ "$RETVAL" = "0" ]; then
        info success
    else
        info failure
    fi

    shpec_end_block

    return $RETVAL
}

var() {
    shpec_var "$@"
}
