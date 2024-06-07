#!/bin/bash

# https://www.linuxjournal.com/content/understanding-bash-elements-programming (bash intro)
# https://linuxhandbook.com/bash-test-operators/ (cheatsheet)
# https://unix.stackexchange.com/questions/476853/does-bash-shift-command-change-argument-count (shift changes $#)

readonly CONFIG_FILE=".build-config"

BUILD_TYPE="Debug"
COMPILER="gcc"
BUILD_DIR="build_${BUILD_TYPE}_${COMPILER}"

# no arguments passed and config file exists?
if [[ $# -eq 0 && -f $CONFIG_FILE ]]; then

	source $CONFIG_FILE
	if [[ ! -d $saved ]]; then
		echo "The previous configured build directory ${saved} no longer exists. Running with default options"
	else
		BUILD_DIR=$saved
	fi

else
	# while $# (arguments passed) -gt (greater than) 0
	while [[ $# -gt 0 ]]; do
		case $1 in
		-b | --build)
			BUILD_TYPE=$2
			shift
			;;
		-c | --compiler)
			COMPILER=$2
			shift
			;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
			;;
		esac
		shift
	done

	case $COMPILER in
	clang)
		export CC=clang
		export CXX=clang++
		;;
	gcc)
		export CC=gcc
		export CXX=g++
		;;
	*)
		echo "Invalid compiler: ${COMPILER}. Valid compilers are gcc, clang."
		exit 1
		;;
	esac

	BUILD_DIR="build_${BUILD_TYPE}_${COMPILER}"
fi

echo "saved=\"${BUILD_DIR}\"" >"$CONFIG_FILE"

if [[ ! -d $BUILD_DIR ]]; then
	(
		mkdir "$BUILD_DIR"
		cd "$BUILD_DIR" || exit

		cmake -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" ..
		cp compile_commands.json ../
	)
fi

cd "$BUILD_DIR" || exit

cmake --build .

# nvidia with valgrind (possible driver mem leaks, not as accurate)
# export __GLX_VENDOR_LIBRARY_NAME=nvidia && export __NV_PRIME_RENDER_OFFLOAD=1 && valgrind --leak-check=full ./opengl_playground

# igpu with valgrind
# valgrind --leak-check=full ./opengl_playground

./opengl_playground
