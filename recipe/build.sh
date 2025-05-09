#!/usr/bin/env bash
# Enable bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# ROOTIO is currently off, this could be added after ROOT adds a root-base formula

cmake -LAH \
    -DCMAKE_BUILD_TYPE=${CMAKE_PLATFORM_FLAGS[@]+"${CMAKE_PLATFORM_FLAGS[@]}"} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DHEPMC3_ENABLE_ROOTIO=OFF \
    -DHEPMC3_ENABLE_PYTHON=OFF \
    -DHEPMC3_BUILD_DOCS=ON \
    -DHEPMC3_BUILD_EXAMPLES=ON \
    -DHEPMC3_ENABLE_TEST=ON \
    -S source \
    -B build

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

cd build
ctest

cd "$PREFIX/lib" || exit 1

for lib in libHepMC*; do
    base=$(basename "$lib")
    newname="libHepMC3${base#libHepMC}"
    ln -sf "$base" "$newname"
done

for lib in libHepMCfio*; do
    base=$(basename "$lib")
    newname="libHepMCfio3${base#libHepMCfio}"
    ln -sf "$base" "$newname"
done
