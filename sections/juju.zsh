#
# Juju
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_JUJU_SHOW="${SPACESHIP_JUJU_SHOW=true}"
SPACESHIP_JUJU_PREFIX="${SPACESHIP_JUJU_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_JUJU_SUFFIX="${SPACESHIP_JUJU_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_JUJU_SYMBOL="${SPACESHIP_JUJU_SYMBOL="✨ "}"
SPACESHIP_JUJU_COLOR="${SPACESHIP_JUJU_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_juju() {
  [[ $SPACESHIP_JUJU_SHOW == false ]] && return

  spaceship::exists juju || return

  [[ $GOPATH && "$PWD/" =~ "$GOPATH/src/github.com/juju/juju/" ]] || return

  local juju_version=$(juju --version 2> /dev/null)
  local juju_model=$(juju models --format=json 2> /dev/null | jq -r ".[\"current-model\"]" || true)

  spaceship::section \
    "$SPACESHIP_JUJU_COLOR" \
    "$SPACESHIP_JUJU_PREFIX" \
    "${SPACESHIP_JUJU_SYMBOL}${juju_version} (${juju_model})" \
    "$SPACESHIP_JUJU_SUFFIX"
}
