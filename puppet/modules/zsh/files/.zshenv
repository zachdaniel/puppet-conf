export TERM=xterm-256color

export EDITOR="vim"
export ALTERNATE_EDITOR=""
export PATH="/conf/scripts:$PATH"

# Load all files from ~/zshenv.d directory
if [ -d ~/.zshenv.d ]; then
    for file in ~/.zshenv.d/*.zsh; do
        source $file
    done
fi
