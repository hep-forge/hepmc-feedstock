#!/usr/bin/env bash

PYTHON_VERSION=$(${PREFIX}/bin/python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PYTHON_VERSION_NO_DOT=$(echo "$PYTHON_VERSION" | tr -d '.')

SITEARCH=$(${PREFIX}/bin/python -c "import sysconfig; print(sysconfig.get_path('platlib'))")


cmake -LAH -S source -B build \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DPYTHIA8_ROOT_DIR=${PREFIX} \
    -DHEPMC3_ENABLE_PROTOBUFIO=OFF \
    -DHEPMC3_BUILD_DOCS=OFF \
    -DHEPMC3_ENABLE_ROOTIO=ON \
    -DHEPMC3_BUILD_EXAMPLES=ON \
    -DHEPMC3_ENABLE_TEST=ON \
    -DHEPMC3_ENABLE_PYTHON=ON \
    -DHEPMC3_INSTALL_INTERFACES=ON \
    -DHEPMC3_PYTHON_VERSIONS="${PYTHON_VERSION}" \
    -DHEPMC3_Python_SITEARCH${PYTHON_VERSION_NO_DOT}="${SITEARCH}"

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

cd build
ctest

cd "$PREFIX/lib" || exit 1

# for lib in $(ls libHepMC*); do
#     base=$(basename "$lib")
#     newname="libHepMC3${base#libHepMC}"
#     ln -sf "$base" "$newname"
# done

# for lib in $(ls libHepMCfio*); do
#     base=$(basename "$lib")
#     newname="libHepMCfio3${base#libHepMCfio}"
#     ln -sf "$base" "$newname"
# done
