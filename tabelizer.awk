# NR == 1 {
#     for(i = 1; i <= NF; i++) {
# 	colname[i]=$i
#     }
# }

# NR > 1 {
NF {
    for(i = 1; i <= NF; i++) {
        if (length($i) > maxlen[i]) {
            maxlen[i] = length($i)
	}
    }
}

NF {
    for (i = 0; i <= NF; i++) {
	printf "%" maxlen[i] "s", maxlen[i]
    }

    printf "\n"
}

{
}

END {
    for (i in maxlen) {
	# print colname[i], ":", maxlen[i];
    }
}
