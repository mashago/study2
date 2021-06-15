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

func_list=(
	test0
	test1
	test2
	test3
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
