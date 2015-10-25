# Code Review
function review(){

    # Print the usage doc
    function usage (){
        echo ""
        echo "review <workspace_name> [options]"
        echo ""
        echo "options:"
        echo "  -p, --parent=<branch>     Branch to base the diff from"
        echo "  -u, --update=<id>         Id of CR to update"
        echo "  -h, --help                You're looking at it..."
        echo ""
        echo "review expects a WORKSPACES env variable to be set as an associative array mapping a"
        echo "workspace name to paths. Each value is a string of the following format local:remote."
        echo ""
    }

    # Set and validate the workspace
    if [[ -z $1 || $1 == '-h' || $1 == '--help' ]]; then
        usage
        return
    fi
   
    if [[ -z $WORKSPACES ]]; then
        print "No WORKSPACES env variable set."
        usage
        return
    fi
    
    if [[ -z $WORKSPACES[$1] ]]; then
        print "Workspace doesn't exist. Select from $fg[green][${(k)WORKSPACES}]$reset_color"
        return
    fi
   
    workspace=$(echo "$WORKSPACES[$1]" | cut -d ':' -f 1)

    if [[ ! -f $workspace/packageInfo ]]; then
        print "The given path doesn't appear to be a valid workspace. Please provide a valid workspace."
        usage
        return
    fi   
 
    if [[ ! -d $workspace/src ]]; then
        print "The workspace doesn't appear to have any packages checked out."
        usage
        return
    fi

    # Parse the options
    while [ "$2" != "" ]; do
        PARAM=`echo $2 | awk -F= '{print $1}'`
        VALUE=`echo $2 | awk -F= '{print $2}'`
        case $PARAM in
            -h | --help) usage; exit ;;
            -u | --update) update_id=$VALUE ;;
            -p | --parent) parent_branch=$VALUE ;;
            -o | --open) open_in_browser=true ;;
            *)
                echo "ERROR: unknown parameter \"$PARAM\""
                usage
                exit 1
            ;;
        esac
        shift
    done 
        
    # Gather package information
    set -A packages
    workspace_clean=true
    original_pwd=$PWD
    for package in $workspace/src/*; do
        # Save the package names
        packages+=(${package:t})
        
        # Check if each package has a clean git status
        cd $package && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && workspace_clean=false
    done
    PWD=$original_pwd

    # Check if workspace is clean and if not, exit with message 
    if [[ "$workspace_clean" == false ]]; then 
        print "Yo dude, the packages are dirty. Clean up your mess first."
        return
    fi
    
    # Setup the parameters to send post-review
    set -A flags
    flags+=("\-t ${(j: -t :)packages}")
    flags+=("--parent=${parent_branch-mainline}")

    # Decide if this is an update or new
    if [[ -z $update_id ]]; then 
        flags+=("--no-review-guess")
        flags+=("--description-file=$REVIEW_DSC_FILE")
        flags+=("--testing-done-file=$REVIEW_TST_FILE")
        flags+=("--target-groups=$REVIEW_TARGET_GROUPS")
    else
        flags+=("--review-request-id=$update_id")
    fi 
        
    # Finally, lets execute!
    print -z post-review $flags
   
    #TODO: When back on the network, parse the output from post-review to get the id. Then 
    #      we can use the ID to generate a URL to pipe to the pasteboard
}
