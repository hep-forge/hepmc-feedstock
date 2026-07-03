# hepmc-feedstock

[![hep-forge](https://img.shields.io/badge/package-hep--forge%2Fhepmc-orange.svg)](https://anaconda.org/hep-forge/hepmc)
[![Build & Upload](https://github.com/hep-forge/hepmc-feedstock/actions/workflows/autoupload.yml/badge.svg)](https://github.com/hep-forge/hepmc-feedstock/actions/workflows/autoupload.yml)
[![Anaconda Version](https://anaconda.org/hep-forge/hepmc/badges/version.svg)](https://anaconda.org/hep-forge/hepmc)
[![Anaconda Platforms](https://anaconda.org/hep-forge/hepmc/badges/platforms.svg)](https://anaconda.org/hep-forge/hepmc)

Feedstock for [hepmc](https://hepmc.web.cern.ch/hepmc/) — part of [hep-forge](https://anaconda.org/hep-forge).
Builds linux-amd64 + linux-arm64 in one matrix workflow and uploads to the
[hep-forge](https://anaconda.org/hep-forge) Anaconda channel.

HepMC3 is a new rewrite of HepMC event record.

## Architectures

| Architecture | Latest published |
|--------------|------------------|
| linux-amd64 (`linux-64`) | ✅ `3.3.0` |
| linux-arm64 (`linux-aarch64`) | ❌ not published |

_As of the last feedstock render; the badges above are live._


## Install

```bash
conda install -c hep-forge -c conda-forge hepmc
```

## Maintainers

* [@meiyasan](https://github.com/meiyasan/)

