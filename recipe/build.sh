#!/usr/bin/env bash

PYTHON_VERSION=$(${PREFIX}/bin/python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PYTHON_VERSION_NO_DOT=$(echo "$PYTHON_VERSION" | tr -d '.')

SITEARCH=$(${PREFIX}/bin/python -c "import sysconfig; print(sysconfig.get_path('platlib'))")

# @TODO: Introduce major env variable and adapt for HepMC2
#CMake Error at CMakeLists.txt:26 (message):
#  You must specify the momentum units with -Dmomentum:STRING=[MEV|GEV]
  
# ${CMAKE_ARGS} carries conda-build's own -DCMAKE_BUILD_TYPE=Release
# (plus toolchain/strip paths) -- omitting it leaves CMAKE_BUILD_TYPE
# unset (this project's own CMakeLists.txt never defaults it either),
# producing an unoptimized, unstripped debug-info binary.
cmake -LAH -S source -B build ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DPYTHIA8_ROOT_DIR=${PREFIX} \
    -DHEPMC3_ENABLE_PROTOBUFIO=OFF \
    -DHEPMC3_BUILD_DOCS=OFF \
    -DHEPMC3_ENABLE_ROOTIO=ON \
    -DHEPMC3_BUILD_EXAMPLES=OFF \
    -DHEPMC3_ENABLE_TEST=OFF \
    -DHEPMC3_ENABLE_PYTHON=ON \
    -DHEPMC3_INSTALL_INTERFACES=ON \
    -DHEPMC3_PYTHON_VERSIONS="${PYTHON_VERSION}" \
    -Dmomentum:STRING="GEV" -Dlength:STRING=CM \
    -DHEPMC3_Python_SITEARCH${PYTHON_VERSION_NO_DOT}="${SITEARCH}"

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

cd build
ctest
