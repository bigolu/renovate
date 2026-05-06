set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob
shopt -s inherit_errexit

args=()

export RENOVATE_CONFIG_FILE="${RENOVATE_CONFIG_FILE:-$PWD/global.json}"

# If a CI run fails, we'll have all the debug information without
# having to rerun it.
export LOG_LEVEL="${LOG_LEVEL:-debug}"

if [[ ''${CI:-} != 'true' ]]; then
	export RENOVATE_DRY_RUN='full'
	args+=(--platform=local)
fi

renovate "${args[@]}" "$@"
