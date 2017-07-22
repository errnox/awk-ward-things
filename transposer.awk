BEGIN {
  OFS = FS = "";
  max = 0;
}

# keep track of the maximum number of fields
NF > max {
  max = NF;
}

# assign each field to an array by line number and field number
{
  for (i=1; i<=NF; i++) {
    a[NR,i] = $i;
  }
}

# print transposed data
END {
  for (i=1; i<=max; i++) {
    for (j=1; j<=NR; j++) {
      printf("%s%s", a[j,i], j==NR ? ORS : OFS);
    }
  }
}

