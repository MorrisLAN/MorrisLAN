#!/bin/bash
# Install helper scripts to /usr/bin
set -e

find . -type f -name '*.sh' | while read -r SCRIPT; do
    SCRIPT_NAME=$(basename "${SCRIPT}" .sh)

    if [[ "${SCRIPT}" == "./$(basename $0)" ]]; then
        continue
    fi

    if [[ -f "/usr/bin/${SCRIPT_NAME}" ]]; then
        echo "Updating ${SCRIPT_NAME}"
    else
        echo "Installing ${SCRIPT_NAME}"
    fi

    sudo cp "${SCRIPT}" "/usr/bin/${SCRIPT_NAME}"
    sudo chmod +x "/usr/bin/${SCRIPT_NAME}"
done

echo "Done."
