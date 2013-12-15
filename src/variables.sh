shpec_var() {
    if [ "$#" -ge "2" ]; then
        shpec_set_var "$1" "$2"
    else
        shpec_get_var "$1"
    fi
}

shpec_unset_var() {
    eval "unset SHPEC_${1}_${SHPEC_LEVEL}"
}

shpec_set_var() {
    eval "SHPEC_${1}_${SHPEC_LEVEL}=$(shpec_quote "$2")"
    {
        eval "printf \"%s\n\" \"\$SHPEC_VARIABLES_${SHPEC_LEVEL}\"" |
        tr ' ' "\n" |
        grep -q -F "$1"
    } ||
    eval "SHPEC_VARIABLES_${SHPEC_LEVEL}=\"$1 \$SHPEC_VARIABLES_${SHPEC_LEVEL}\""
}

shpec_get_var_1() {
    eval "printf \"%s\\n\" \"\$SHPEC_${SHPEC_VAR_NAME}_${SHPEC_LEVEL}\""
}

shpec_get_var() {
    SHPEC_VAR_NAME="$1"
    (
        RESULT="$(shpec_get_var_1)"
        while [ -z "$RESULT" ]; do
            if [ "$SHPEC_LEVEL" -le 0 ]; then break; fi
            SHPEC_LEVEL=$((SHPEC_LEVEL - 1))
            RESULT="$(shpec_get_var_1)"
        done
        [ -n "$RESULT" ] && printf "%s\n" "$RESULT"
    )
}
