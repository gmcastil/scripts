#!/bin/bash

TOOLS_ROOT=/tools

questa_version="22.2"
questa_root="${TOOLS_ROOT}/Intel/FPGA/${questa_version}/questa_fe"

MTI_VCO_MODE=64
MODEL_TECH="${questa_root}/bin"
PATH="${MODEL_TECH}:${PATH}"
#LM_LICENSE_FILE="${HOME}/licenses/LR-160810_License.dat"
LM_LICENSE_FILE="${HOME}/licenses/LR-222096_License.dat"

export TOOLS_ROOT
export MTI_VCO_MODE
export MODEL_TECH
export PATH
export LM_LICENSE_FILE

