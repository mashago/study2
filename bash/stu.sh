#!/bin/bash


function test0() {
	echo "test0 param"

	param1=123
	param2="abc"
	echo "param1:" $param1 " param2:" $param2
	echo "param1: $param1  param2: $param2"
	echo "param1: ${param1}  param2: ${param2}"
	echo 'param1: ${param1}  param2: ${param2}'
	echo "======="

	unset param2
	echo "param1: ${param1}  param2: ${param2}"
	echo "======="

	param3="masha"
	str="my name is \"$param3\""
	echo "str:" $str
	echo "======="

	param4="abcd"
	echo "size of params:" ${#param4}
	echo "size of params: ${#param4}"
	echo "param4:2:2: ${param4:2:2}"
	echo "======="

}

function test1() {
	echo "test1 array"

	arr=("a" "b" "c" "d")
	echo '$arr' $arr
	echo '${arr[@]}' ${arr[@]}
	echo '${arr[0]}' ${arr[0]}
	echo '${arr[1]}' ${arr[1]}
	echo '${arr[2]}' ${arr[2]}
	echo '${arr[3]}' ${arr[3]}
	# get array len
	echo '${#arr[@]}' ${#arr[@]}
	# get arr[0] len
	echo '${#arr[0]}' ${#arr[0]}
}

function test_params() {
	for i in $*
	do
		echo $i
	done
	echo "======="

	for i in "$*"
	do
		echo $i
	done
	echo "======="

	for i in $@; do
		echo $i
	done
	echo "======="

	for i in "$@"; do
		echo $i
	done
	echo "======="
}

function test2() {
	test_params 1, 2, 3, 4
}

function test3() {
    arr1=(1, 2, 3, 4)
    echo "arr1[0]=${arr1[0]}"
    echo "#arr1[@]=${#arr1[@]}"
    echo "======="
    for v in ${arr1[@]}; do
        echo $v
    done
}

function test4() {
    val=`expr 2 + 1`
    echo "val=$val"

    echo "======="

    a=1
    b=1
    c=2

    if [ $a -eq $b ]
    then
        echo "a==b"
    fi

    if [ $a -ne $c ]
    then
        echo "a!=c"
    fi

    if [ $c -gt $a ]
    then
        echo "c>a"
    fi

    if [ $a -lt $c ]
    then
        echo "a<c"
    fi

    if [ $a -ge $b ]
    then
        echo "a>=b"
    fi

    if [ $a -le $b ]
    then
        echo "a<=b"
    fi

    if [ $a != $c ]
    then
        echo "a!=c"
    fi

    if [ ! $a -gt $c ]
    then
        echo "!a>c"
    fi

    echo "======="

    if [ $a -eq $b -o $a -eq $c ]
    then
        echo "a==b or a=c"
    fi

    if [ $a -eq $b -a $a -ne $c ]
    then
        echo "a==b and a!=c"
    fi

    if [[ $a -eq $b || $a -eq $c ]]
    then
        echo "a==b || a=c"
    fi

    if [[ $a -eq $b && $a -ne $c ]]
    then
        echo "a==b && a!=c"
    fi

    echo "======="

    str1="abc"
    str2="abc"
    str3="efg"
    str4=""

    if [ $str1 == $str2 ]
    then
        echo "str1==str2"
    fi

    if [ $str1 != $str3 ]
    then
        echo "str1!=str3"
    fi

    if [ -z $str4 ]
    then
        echo "len(str4)==0"
    fi

    if [ -n $str1 ]
    then
        echo "len(str1)!=0"
    fi

    if [ $str4 ]
    then
        echo "str4 not empty"
    else
        echo "str4 empty"
    fi

}

func_list=(
	test0
	test1
	test2
	test3
	test4
)
readonly func_list

function main() {
	# $0 : file name
	echo "hello bash $0"

	idx=`expr ${#func_list[@]} - 1`
	# $# : input count
	if [ $# -ne 0 ]
	then
		# string to num
		i=`expr $1`
		if [[ $i -ge 0 && $i -le $idx ]]
		then
			idx=$i
		fi
	fi

	echo $idx

	${func_list[${idx}]}
}

echo 'params count $#' $#
echo 'all parmas in a string $*' $*
echo 'all params in a string "$*"' "$*"
echo 'pid $$' $$
echo 'last pid $!' $!
echo 'all params in a string $@' $@
echo 'all params list "$@"' "$@"
echo 'shell option $-' $-
echo 'last exit status $?' $?
echo "======="

# $* == $@ : all params in one string
# "$@" : "$1" "$2" ...
main "$@"
