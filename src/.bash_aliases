export EDITOR=vim
export VISUAL=vim

###############
##  Aliases  ##
###############

# Make `ls` more robust
alias l='ls -1'
alias la='ls -lhAF'
alias ll='ls -lhF'
alias lt="ls -lhtrF"
alias l.="ls -lhtrdF .*"

# Welcome Message
clear

echo -e $(tput setaf 6) "      _ _ _     _____       _              "
echo -e $(tput setaf 6) "     | (_) |   / ____|     | |             "
echo -e $(tput setaf 6) "     | |_| |__| (___   __ _| | ___  ___    "
echo    $(tput setaf 6) " _   | | | '_ \\\\___ \ / _\` | |/ _ \/ __|"
echo -e $(tput setaf 6) "| |__| | | |_) |___) | (_| | |  __/\__ \   "$(tput bold)$(tput setaf 7)"         _"$(tput sgr0)
echo -e $(tput setaf 6) " \____/|_|_.__/_____/"$(tput bold)$(tput setaf 7)"/\\"$(tput sgr0)$(tput setaf 6)"__,_|_|\___||___/   " $(tput bold)$(tput setaf 7)"       | |     "
echo -e $(tput bold)$(tput setaf 7) "                    /  \   _ __ _ __ ___   __ _  __| | __ _ "
echo -e $(tput bold)$(tput setaf 7) "                   / /\ \ | '__| '_ \` _ \ / _\` |/  \` |/ _\` |"
echo -e $(tput bold)$(tput setaf 7) "                  / ____ \| |  | | | | | | (_| | (_| | (_| |"
echo -e $(tput bold)$(tput setaf 7) "                 /_/    \_\_|  |_| |_| |_|\__,_|\__,_|\__,_|"
echo
echo -e $(tput setaf 5)"Ahoy, Captain! Welcome aboard. The Armada is ready and awaiting your orders."
echo
