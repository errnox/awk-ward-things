if (($# >= 2)) && [[ $1 = '-d' ]]; then
    depth=$2
    shift 2;
fi

title="man $*"
printf '%s\n' "$title";
eval printf '%.s-' {0..${#title}}; printf \\n
man "$@" | col -b | awk -v depth="${depth-1}" '
{
    gsub(/\t/,"        ");
    a[NR] = $0;
    sub(/^[[:space:]]*/,"",a[NR]);
}

{
    sub(/[^[:space:]].*/,"");
    b[NR] = length;
    c[length]; # De-duplicate.
}

END {
    # Expand into a key-value non-sparse array.
    for(k in c) {
        d[n++] = k
    }

    # Bubble sort.
    for(i = 0; i < n; i++) {
        for(j = i; j < n; j++) {
            if(d[i]+0 > d[j]+0) {
                # Swap.
                t = d[i];
                d[i] = d[j];
                d[j] = t;
            }
        }
    }

    # Inverse map.
    for(k in d) {
        e[d[k]] = k;
    }

    # Skip header and footer.
    for(i = 2; i < NR; i++) {
        if(b[i] <= d[depth-1]+0 && a[i]) {
            s = "";
            for(j = 0; j < 8 * e[b[i]]; j++) {
                s = s " ";
            }
            print s "- " a[i];
        }
    }
}'
