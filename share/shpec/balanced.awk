#! awk -f
BEGIN {
    open=0
}

$1 ~ /(describe|it)/ {
    open++
}

open > 0 {
    print $0
}

$1 ~ /end/ {
    open--
    if (open == 0) {
        exit 0
    }
}
