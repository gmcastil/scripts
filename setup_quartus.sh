#!/bin/bash

# 

err () {
    local msg
    msg="$1"
    printf 'Error: %s\n' "$msg" >&2
    return 0
}

# Check if the script is being sourced, not executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    err "Script needs to be sourced into a running shell"
    exit 1
fi

# Ensure TOOLS_ROOT is set by the caller
if [[ -z "$TOOLS_ROOT" ]]; then
    err "TOOLS_ROOT is unset"
    return 1
fi

# Set LC_ALL to match LANG (en_US.UTF-8)
if [[ "$LANG" != "en_US.UTF-8" ]]; then
    err "Problem setting locale. LANG had unexpected value of $LANG"
    return 1
fi
LC_ALL="en_US.UTF-8"

LM_LICENSE_FILE="$HOME/licenses/LR-160810_License.dat"
# Ensure that the license file exists
if [[ ! -f "$LM_LICENSE_FILE" ]]; then
    err "License file not found at $LM_LICENSE_FILE"
    return 1
fi

# Default to version 22.2 if not provided
quartus_ver=${1:-22.2}

# Set environment variables based on the version
case "$quartus_ver" in
    "22.2")
        QUARTUS_ROOTDIR="${TOOLS_ROOT}/Intel/FPGA/22.2/quartus"
        ;;
    *)
        echo "Unsupported Quartus version: $quartus_ver"
        return 1
        ;;
esac

# Set up environment variables
QUARTUS_ROOTDIR_OVERRIDE="$QUARTUS_ROOTDIR"
QUARTUS_LIBRARY_PATH="$QUARTUS_ROOTDIR/linux64/lib"
QSYS_ROOTDIR="$QUARTUS_ROOTDIR/qsys/bin"
PATH="$QUARTUS_ROOTDIR/bin:$QSYS_ROOTDIR:$PATH"

export LC_ALL
export LM_LICENSE_FILE
export QUARTUS_ROOTDIR_OVERRIDE
export QUARTUS_LIBRARY_PATH
export QSYS_ROOTDIR
export PATH

# Confirmation
command -v quartus >/dev/null 2>&1 ||
    { err "Could not find quartus in PATH. Check NFS or TOOLS_ROOT.\n"; return 1; }

return 0
