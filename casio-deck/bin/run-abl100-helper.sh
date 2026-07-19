#!/usr/bin/env bash
set -euo pipefail

plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
helper_dir="$plugin_dir/helper"
venv_dir="${CASIO_DECK_HELPER_VENV:-$helper_dir/.venv}"

if command -v uv >/dev/null 2>&1; then
  export UV_PROJECT_ENVIRONMENT="$venv_dir"
  exec uv run --project "$helper_dir" python -m casio_deck_helper.cli "$@"
fi

try_python_venv() {
  local python_bin="$venv_dir/bin/python"

  if [ -x "$python_bin" ]; then
    if ! "$python_bin" -c 'import bleak, gshock_api, casio_deck_helper' >/dev/null 2>&1; then
      "$python_bin" -m pip install -e "$helper_dir" || return 1
    fi

    exec "$python_bin" -m casio_deck_helper.cli "$@"
  fi

  command -v python3 >/dev/null 2>&1 || return 1
  python3 -m venv "$venv_dir" || return 1

  if ! "$python_bin" -c 'import bleak, gshock_api, casio_deck_helper' >/dev/null 2>&1; then
    "$python_bin" -m pip install -e "$helper_dir" || return 1
  fi

  exec "$python_bin" -m casio_deck_helper.cli "$@"
}

if try_python_venv "$@"; then
  exit 0
fi

if command -v nix >/dev/null 2>&1; then
  exec nix shell nixpkgs#uv nixpkgs#bluez --command \
    env UV_PROJECT_ENVIRONMENT="$venv_dir" \
    uv run --project "$helper_dir" python -m casio_deck_helper.cli "$@"
fi

printf '%s\n' 'error helper runtime unavailable: install uv, Python 3 with venv support, or Nix'
cat >&2 <<'EOF'
error: could not start the Casio Deck helper.

Install uv, or install Python 3 with venv support, or run on Nix/NixOS with nix available:
  python3 -m venv --help
  nix shell nixpkgs#uv nixpkgs#bluez
EOF
exit 127
