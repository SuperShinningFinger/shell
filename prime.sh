#!/bin/bash

declare -a prime
declare -a is_prime
sol()
{

    for m in `seq 1 10000`;do
        prime[$m]=0
        is_prime[$m]=0
    done


    for i in `seq 2 10000`;do
        if [[ prime[i] -eq 0  ]];then
            prime[++prime[0]]=$i
            is_prime[i]=1
        fi
        for (( j=1; j<=prime[0]&&prime[j]*i<=10000; j++));do
            prime[prime[j]*i]=1
            if [[ i%prime[j] -eq 0  ]];then
                break;
            fi
        done
    done
}


sol
while true;do
    read input
    if [[ $input -eq 1  ]];then
        printf "1 is not prime\n"
        continue;
    fi
  
    if [[  ${is_prime[$input]} -eq 1  ]];then
        printf "%d is prime\n" "$input"
    else
        printf "%d is not prime\n" "$input"
    fi
done
