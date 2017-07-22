# Builds a frequency list

{
    for (i = 0; i <= NF; i++) {
	freq[$i]++
    }
}

END {
    for (word in freq) {
	printf "%s    %s\n", freq[word], word
    }
}

