#!/usr/bin/env sh

endpath="$HOME/.fudesign2008.vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e "$2" ] ; then
        ln -s "$1" "$2"
    fi
}

echo "Thanks for installing fudesign2008.vim"

# Backup existing .vim stuff
echo "backing up current vim config"
today=$(date +%Y%m%d)
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do
    [ -e "$i" ] && [ ! -L "$i" ] && mv "$i" "$i.$today";
done


if [ ! -e "$endpath/.git" ]; then
    echo "cloning fudesign2008.vim"
    git clone --depth 1 --recursive -b fuyg/plug https://github.com/FuDesign2008/fudesign2008.vim.git "$endpath"
else
    echo "updating fudesign2008.vim"
    cd "$endpath" && git pull && git checkout fuyg/plug
fi


echo "setting up symlinks"
lnif "$endpath/.vimrc" "$HOME/.vimrc"
lnif "$endpath/.vimrc.fork" "$HOME/.vimrc.fork"
lnif "$endpath/.vimrc.bundles" "$HOME/.vimrc.bundles"
lnif "$endpath/.vimrc.bundles.fork" "$HOME/.vimrc.bundles.fork"
lnif "$endpath/.vim" "$HOME/.vim"
lnif "$endpath/coc-settings.json" "$HOME/.vim/coc-settings.json"





if [ ! -d "$endpath/.vim/bundle" ]; then
    mkdir -p "$endpath/.vim/bundle"
fi



if [ ! -e "$endpath/.vim/autoload/plug.vim" ];then
    echo "Install Plug"
    curl -fLo "$endpath/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


echo "update/install plugins using Plug"
# vim -es -u "$endpath/.vimrc.bundles" -i NONE -c "PlugInstall" -c "qa"
vim -u "$endpath/.vimrc.bundles" +PlugUpdate! +PlugClean +qall


