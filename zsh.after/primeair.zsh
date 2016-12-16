#
# Executes Prime Air specific commands at the start of an interactive session.
#
# Authors:
#   Sean R. Quinn <srquinn21@gmail.com>
#

#==============================================================================
#  Aliases
#==============================================================================

alias review="adn-code-review -a -g primeair-ground -w ryanstew,ebigelow,bradenro $@"
alias ureview="adn-code-review -a $@"

#==============================================================================
#  Utilities
#==============================================================================

# Starts a Dockerized SAA Simbird
function start-simbird () {
  local ip="$1"
  local simbird="${2:-docker}"k
  local simbird_ws="$HOME/workspaces/simbird/src/Adn-saa"
  local simbird_config="$simbird_ws/src/SAA/Birds/${simbird}.cfg"
  local simbird_default="$HOME/utils/simbird/${simbird}.cfg"
  cd $simbird_ws
  echo "Updating bird file [$simbird] to redirect to [$ip]"
  \cp -f $simbird_default $simbird_config
  sed "s/upstream_hostname=.*$/upstream_hostname=$ip/" $simbird_config > $simbird_config.tmp
  mv -f $simbird_config.tmp $simbird_config
  brazil-build run_saa_ros bird=$simbird
}

function run_ground () {
  adn adtlm image-pull-run r.adtlm.net/adnground-$1 AdnGround
}
