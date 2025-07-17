#!/usr/bin/env bash
# Enable bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

PYTHON_VERSION=$($PYTHON -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

cmake -LAH -S source -B build \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DHEPMC3_ENABLE_PROTOBUFIO=OFF \
    -DHEPMC3_BUILD_DOCS=OFF \
    -DHEPMC3_ENABLE_ROOTIO=ON \
    -DHEPMC3_BUILD_EXAMPLES=ON \
    -DHEPMC3_ENABLE_TEST=ON \
    -DHEPMC3_ENABLE_PYTHON=ON \
    -DHEPMC3_PYTHON_VERSIONS=${PYTHON_VERSION}
    -DHEPMC3_Python_SITEARCH=$PREFIX/lib/python${PYTHON_VERSION}/site-packages
    -DHEPMC3_INSTALL_INTERFACES=ON

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

cd build
ctest

cd "$PREFIX/lib" || exit 1

for lib in $(ls libHepMC*); do
    base=$(basename "$lib")
    newname="libHepMC3${base#libHepMC}"
    ln -sf "$base" "$newname"
done

for lib in $(ls libHepMCfio*); do
    base=$(basename "$lib")
    newname="libHepMCfio3${base#libHepMCfio}"
    ln -sf "$base" "$newname"
done
