#!/bin/bash

sudo apt-get install build-essential cmake curl file g++-multilib gcc-multilib git libcap-dev libgoogle-perftools-dev libncurses5-dev libsqlite3-dev libtcmalloc-minimal4 python3-pip unzip graphviz doxygen
sudo pip3 install lit wllvm
sudo apt-get install python3-tabulate
pip3 install --user lit wllvm
export PATH=/.local/bin:$PATH
sudo apt-get install clang-13 llvm-13 llvm-13-dev llvm-13-tools
git clone https://github.com/stp/stp.git
cd stp
git checkout tags/2.3.3
mkdir build
cd build
cmake ..
make
sudo make install
git clone https://github.com/klee/klee-uclibc.git
cd klee-uclibc
./configure --make-llvm-lib
make -j2
cd ..
git clone https://github.com/klee/klee.git
export PATH=/usr/lib/clang/13.0.1:$PATH
cd klee
mkdir build
cd build
export PATH=/home/makri/stp:$PATH
export PATH=/home/makri/stp/include:$PATH
export PATH=/home/makri/stp/include/stp:$PATH
export CXXFLAGS="-I/home/makri/stp/include/stp"
export LDFLAGS="-L/home/makri/stp/build"
export CPLUS_INCLUDE_PATH=/home/makri/stp/include
export LD_LIBRARY_PATH=/path/to/stp/build/lib:$LD_LIBRARY_PATH
cmake -DENABLE_SOLVER_STP=ON -DENABLE_POSIX_RUNTIME=ON -DKLEE_UCLIBC_PATH=/home/makri/klee-uclibc -DENABLE_UNIT_TESTS=OFF /home/makri/klee
make
