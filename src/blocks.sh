shpec_blocks() {
    printf "%s\n" "$SHPEC_CURRENT_BLOCK" | tr : "\n"
}

shpec_current_block() {
    shpec_blocks | head -1
}

shpec_push_block() {
    SHPEC_CURRENT_BLOCK=$1:$SHPEC_CURRENT_BLOCK
    SHPEC_LEVEL=$((SHPEC_LEVEL + 1))
}

shpec_pop_block() {
    SHPEC_CURRENT_BLOCK=$(shpec_blocks | tail -n +2)
    SHPEC_LEVEL=$((SHPEC_LEVEL - 1))
}

shpec_begin_block() {
    shpec_push_block "$1"
    shpec_var BLOCK_NAME "$(shpec_current_block)"
    eval "$(shpec_current_block)_enter"
}

shpec_end_block() {
    eval "$(shpec_current_block)_leave"

    for variable in $(shpec_var VARIABLES)
    do
        shpec_unset_var "$variable"
    done

    shpec_pop_block
}
