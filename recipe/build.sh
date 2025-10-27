#!/usr/bin/env bash

PYTHON_VERSION=$(${PREFIX}/bin/python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PYTHON_VERSION_NO_DOT=$(echo "$PYTHON_VERSION" | tr -d '.')

SITEARCH=$(${PREFIX}/bin/python -c "import sysconfig; print(sysconfig.get_path('platlib'))")

# @TODO: Introduce major env variable and adapt for HepMC2
#CMake Error at CMakeLists.txt:26 (message):
#  You must specify the momentum units with -Dmomentum:STRING=[MEV|GEV]
  
cmake -LAH -S source -B build \
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
    -Dmomentum:STRING="GEV" \
    -DHEPMC3_Python_SITEARCH${PYTHON_VERSION_NO_DOT}="${SITEARCH}"

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

cd build
ctest
