#!/bin/bash

# Intended to be sourced into a running subshell, so that the ModelSim binaries
# are a) in the PATH, b) able to run with LD_LIBRARY_PATH set properly, and c)
# unsetting whatever nonsense happens to be in the user environment.

# Since this is intended to be sourced into a running shell, if it fails at any
# point, it will likely leave the calling environment in a modified state (i.e.,
# it doesn't attempt to save variables like PATH or LD_LIBRARY_PATH and restore
# them if it fails). This shouldn't be a problem, but intelligent folks should
# be aware of this. If the TOOLS_ROOT variable is not set by the parent
# environment or the location it points at is unavailable such as the NFS server
# is down, this script is going to fail.
if [[ "${BASH_SOURCE[0]}" -ef "${0}" ]]; then
    printf '%s\n' >&2 "Must be sourced by or into a running bash shell"
    exit 1
fi

function err () {
    printf 'Error: %s\n' >&2 "${1}"
    return 0
}

TOOLS_ROOT=${TOOLS_ROOT:-'/tools'}

modelsim_version='16.1'
modelsim_root="${TOOLS_ROOT}/Intel/ModelSim/${modelsim_version}/modelsim_ase"

ok_to_export=0

# In principle, any changes to LD_LIBRARY_PATH need to be made here prior to
# exporting it later.  This is largely because a specific version of the 
# 32-bit libfreetype library needs to be installed alongside the system version
# and ModelSim will fail to run if it doesn't get found.

# Also, even though the tools probably already set this, we set it ourselves
# explicitly
MTI_VCO_MODE=32

# Finally the path needs to be updated a bit so that the ModelSim binaries are
# available
if [[ ! -d "${modelsim_root}/bin" ]]; then
    err "No ModelSim binaries directory at ${modelsim_root}/bin"
    ok_to_export=1
else
    PATH="${modelsim_root}/bin:${PATH}"
fi

if [[ "${ok_to_export}" -ne 0 ]]; then
    err "ModelSim directories not found. Check TOOLS_ROOT value."
    return 1
fi

export LD_LIBRARY_PATH
export MTI_VCO_MODE
export PATH

command -v vsim >/dev/null 2>&1 || \
    { err "vsim not found in PATH"; return 1; }

