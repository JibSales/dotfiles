#==============================================================================
#  Custom Shell Setup 
#==============================================================================

dark() {
    # Use the Solarized Dark Color Scheme
    # Set console colors to Solarized (dark) Colors by overriding the defaults
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#073642:#DC322F:#859900:#B58900:#268BD2:#D33682:#2AA198:#EEE8D5:#002B36:#CB4B16:#586E75:#657B83:#839496:#6C71C4:#93A1A1:#FDF6E3"
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#002B36"
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#657B83"
    fi
}
 
light() {
    # Use the Solarized Light Color Scheme
    # Set consoleconsole colors to Solarized (light) Colors by overriding the defaults
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#859900:#2aa198:#268bd2:#6c71c4:#d33682:#dc322f:#cb4b16:#b58900:#fdf6e3:#eee8d5:#93a1a1:#839496:#657b83:#586e75:#073642:#002b36"
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#FDF6E3"
        gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#839496"
    fi
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
fi

# Lets get GNU Coreutils to give us pretty dircolors
test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`
