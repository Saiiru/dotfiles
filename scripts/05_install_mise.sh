#!/usr/bin/env bash
set -euo pipefail
# instala mise no ~/.local/bin (sem versionar o binário)
curl https://mise.run | sh
echo "mise instalado. Abra um novo shell para carregar."
