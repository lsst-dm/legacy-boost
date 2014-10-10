# EupsPkg config file. Sourced by 'eupspkg'

config()
{
	detect_compiler

	# warn about non-clang builds on Macs
	if [[ "$(uname)" == "Darwin" && "$COMPILER_TYPE" != clang ]]; then
		warn "boost needs clang on OS X (you're compiling it with $COMPILER_TYPE. hope you know what you're doing."
	fi

	if [[ "$COMPILER_TYPE" == clang ]]; then
		WITH_TOOLSET="--with-toolset=clang"
	fi

	./bootstrap.sh --without-libraries=mpi --prefix="$PREFIX" $WITH_TOOLSET
}

build()
{
	c++ -std=c++11 trivial.cc 2>/dev/null
	if (( $? == 0 )); then
		cxx11flags="-std=c++11"
	else
		cxx11flags="-std=c++0x"
	fi	

	./b2 -j $NJOBS cxxflags=$cxx11flags
}

install()
{
	clean_old_install

	./b2 -j $NJOBS install

	install_ups
}

	c++ -std=c++11 trivial.cc 2>/dev/null
	if (( $? == 0 )); then
		echo 'compiler supports c++11'
	else
		echo 'try c++11 instead'
	fi	
