# Finds the full path to the most recent apollo log file
# 
# Input:
#   $1  apollo env alias
#   $2  a string to grep for in the log dir
#   $3  [optional] immediately begins tailing the file on the given server
function get_apollo_log_file(){
    log_dir="/apollo/env/$1/var/output/logs"
    log_file="ls -t $log_dir | grep $2 | head -1 | xargs -I {filename} echo $log_dir/{filename}"

    if [[ -z $3 ]]; then
        print -z $log_file 
    else
        ssh $3 -t "$log_file | xargs tail -F"
    fi
}

function debug(){
    get_apollo_log_file 'HorizontePlatform' 'access' 'devbox'
}
