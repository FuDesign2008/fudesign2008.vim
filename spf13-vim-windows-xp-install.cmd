@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.fudesign2008.vim

@if not exist "%BASE_DIR%" (
        echo backing up existing vim config
        @set today=%DATE%
        @if exist "%HOME%\.vim" call xcopy /s/e/h/y/r/q/i "%HOME%\.vim" "%HOME%\.vim.%today%"
        @if exist "%HOME%\.vimrc" call copy "%HOME%\.vimrc" "%HOME%\.vimrc.%today%"
        @if exist "%HOME%\_vimrc" call copy "%HOME%\_vimrc" "%HOME%\_vimrc.%today%"
        @if exist "%HOME%\.gvimrc" call copy "%HOME%\.gvimrc" "%HOME%\.gvimrc.%today%"
        )

@if exist "%BASE_DIR%" (
        @set ORIGINAL_DIR=%CD%
        echo updating fudesign2008.vim
        chdir /d "%BASE_DIR%" && git pull
        chdir /d "%ORIGINAL_DIR%"
        ) else (
            echo cloning fudesign2008.vim
            call git clone --recursive -b 3.0 https://github.com/FuDesign2008/fudesign2008.vim.git "%BASE_DIR%"
        )

@if not exist  "%BASE_DIR%\.vim\bundle" call mkdir "%BASE_DIR%\.vim\bundle"
call xcopy /s/e/h/y/r/q/i "%BASE_DIR%\.vim" "%HOME%\.vim"
call copy "%BASE_DIR%\.vimrc" "%HOME%\.vimrc"
call copy "%BASE_DIR%\.vimrc" "%HOME%\_vimrc"
call copy "%BASE_DIR%\.vimrc.bundles" "%HOME%\.vimrc.bundles"

@if not exist "%HOME%/.vim/bundle/vundle" call git clone http://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
call vim -u "%BASE_DIR%/.vimrc.bundles" - +BundleInstall! +BundleClean +qall
