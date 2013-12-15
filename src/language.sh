describe() {
    shpec_begin_block describe
    printf "%s\n" "$1" | shpec_indent
}

describe_enter() {
    :
}

describe_leave() {
    :
}

it() {
    shpec_begin_block it
    shpec_var INFO_LABEL "$1"
}

it_enter() {
    :
}

it_leave() {
    if [ "$BLOCK_RETVAL" = "0" ]; then
        info success
    else
        info failure
    fi
}

info() {
    [ -z "$(shpec_var INFO_LABEL)" ] && return 0
    case "$1" in
        failure)
            color red "$(shpec_var INFO_LABEL)"
            (
                FAILURE_MESSAGE="$(shpec_var FAILURE_MESSAGE)"
                [ -n "$FAILURE_MESSAGE" ] && {
                    printf "\n%s" "$FAILURE_MESSAGE" |
                    shpec_prefix_with "$SHPEC_INDENT_STRING"
                }
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
            printf " %s\n" $({
                    printf "%s\n" "$4" |
                    shpec_prefix_with " "
                })
            printf "Got:\n"
            printf " %s\n" $({
                    printf "%s\n" "$1" |
                    shpec_prefix_with " "
                })
        })
        shpec_var FAILURE_MESSAGE "$SHPEC_TMP_BUFFER"

        return 1
    else
        return 0
    fi
}

end() {
    BLOCK_RETVAL=$?

    shpec_end_block

    return $BLOCK_RETVAL
}

var() {
    case "$1" in
        -u|--undef)
            shpec_unset_var "$2"
            ;;
        *)
            shpec_var "$@"
            ;;
    esac
}
