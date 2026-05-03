# Dependencies:
# 	- renovate
#   - git is needed by Renovate
#   - go is needed for the values "gomodTidy" and "gomodUpdateImportPaths" of the
#     Renovate config setting "postUpdateOptions".
#   - regenerate-gomod2nix-lock is needed for a Renovate "postUpgradeTask"
#   - mod is needed for the value "gomodUpdateImportPaths" of the
#     Renovate config setting "postUpdateOptions".

set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob
shopt -s inherit_errexit

export RENOVATE_CONFIG_FILE="${RENOVATE_CONFIG_FILE:-$PWD/global.json}"

# If a CI run fails, we'll have all the debug information without
# having to rerun it.
export LOG_LEVEL='debug'

if [[ ''${CI:-} != 'true' ]]; then
	export RENOVATE_DRY_RUN='full'
fi

renovate
