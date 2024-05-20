
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.fudesign2008.vim
IF NOT EXIST "%BASE_DIR%" (
    call git clone --recursive -b "fuyg/plug" https://github.com/FuDesign2008/fudesign2008.vim.git "%BASE_DIR%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating fudesign2008.vim
    chdir /d "%BASE_DIR%"
    call git pull
    call git checkout "fuyg/plug"
    chdir /d "%ORIGINAL_DIR%"
    call cd "%BASE_DIR%"
)

call mklink "%HOME%\.vimrc" "%BASE_DIR%\.vimrc"
call mklink "%HOME%\_vimrc" "%BASE_DIR%\.vimrc"
call mklink "%HOME%\.vimrc.fork" "%BASE_DIR%\.vimrc.fork"
call mklink "%HOME%\.vimrc.bundles" "%BASE_DIR%\.vimrc.bundles"
call mklink "%HOME%\.vimrc.bundles.fork" "%BASE_DIR%\.vimrc.bundles.fork"
call mklink /J "%HOME%\.vim" "%BASE_DIR%\.vim"

IF NOT EXIST "%BASE_DIR%\.vim\bundle" (
    call mkdir "%BASE_DIR%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/autoload/plug.vim" (
    @REM call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
    @REM call iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    @REM ni $HOME/vimfiles/autoload/plug.vim -Force
    call curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
)

@REM call vim -u "%BASE_DIR%/.vimrc.bundles" +BundleInstall! +BundleClean +qall
call vim -u "%BASE_DIR%/.vimrc.bundles" +PlugUpdate! +PlugClean +qall

