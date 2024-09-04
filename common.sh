#!/bin/bash

# Prints a user-provided error message to stderr
err() {
    local msg
    msg="${1}"
    printf 'Error: %s\n' "${msg}" >&2
    return 0
}

# Prints a timestamp that can be used for logging, filenames, etc.
timestamp() {
    local ts
    ts="$(date +%Y%m%d-%H%M%S)"
    printf '%s' "${ts}" >&1
    return 0
}

# Returns zero if ModelSim executables are found in the current PATH, else non-zero
check_modelsim() {
    command -v vlib >/dev/null 2>&1 || return 1
    command -v vsim >/dev/null 2>&1 || return 1
    command -v vlog >/dev/null 2>&1 || return 1
    command -v vcom >/dev/null 2>&1 || return 1
    command -v vopt >/dev/null 2>&1 || return 1
    command -v vcd2wlf >/dev/null 2>&1 || return 1
    return 0
}

