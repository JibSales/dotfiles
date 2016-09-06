#! /usr/bin/env bash

starting_dir=$PWD
workspace_dir=$PWD
workspace_not_found=0

# Traverse backwards until we find packageInfo
while [ ! -f "./packageInfo" ]; do
  if [[ "$PWD" == "$HOME" ]]; then
    workspace_not_found=1   
    break
  fi
  workspace_dir=$PWD/../
  cd $workspace_dir
done

# Exit if we're not in a workspace
if [[ $workspace_not_found == 1 ]]; then
  echo "No brazil workspace found"
  exit 1
fi

# Get git info for reach package
for package in `ls -1 ./src`; do
	
	# Change directories into package
	cd $workspace_dir/src/${package}
	
	# If user passed fetch flag
	if [[ "$1" == "--fetch" ]]; then
		git fetch origin --quiet
	fi

	# Get some git info
  git_status_msg=$(git status)
  git_branch=$(git rev-parse --abbrev-ref HEAD)
  git_tracking_branch="origin/mainline"
  git_local_rev=$(git rev-parse @)
  git_remote_rev=$(git rev-parse $git_tracking_branch)
  git_base_rev=$(git merge-base @ $git_tracking_branch)

	# Check if the package is synced with origin and print report
	if [[ $git_local_rev == $git_remote_rev ]]; then
   	git_branch_status="\033[0;32mup-to-date\033[0m with" 
  elif [[ $git_local_rev == $git_base_rev ]]; then
   	git_branch_status="\033[0;31mbehind\033[0m" 
  elif [[ $git_remote_rev == $git_base_rev ]]; then
   	git_branch_status="\033[0;31mahead\033[0m of" 
	else 
   	git_branch_status="\033[0;31mdiverged\033[0m" 
	fi

	# Check if the package has any changes and print report
  dirty_files=""
	if [[ $(git status -s) != "" ]]; then
	  dirty_files="\n  Dirty files:\n$(echo "$(git status -s)" | sed -e 's/^/    /')"
	fi

	# Print the report
	echo -e "\033[0;36m$package\033[0m\n  ${git_branch} is ${git_branch_status} ${git_tracking_branch}${dirty_files}"

	# Go back to the workspace root
	cd $workspace_dir
done

# Go back to where we started
cd $starting_dir
