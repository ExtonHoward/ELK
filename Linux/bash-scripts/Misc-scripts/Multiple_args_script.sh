#!/usr/bin/env bash

# script takes 2 args. first is time that must be wrapped in single quotes. second is 4 digit date

# grep "$1" $2_Dealer_schedule | awk -F'\t' '{print $1, $3}'

# script takes 3 args. first is time that must be wrapped in single quotes. Second is 4 digit date. Third is $# for column of dealer
# and it must be wrapped in single quotes. 

grep "$1" $2_Dealer_schedule | awk -F'\t' '{print $1, '$3'}'

