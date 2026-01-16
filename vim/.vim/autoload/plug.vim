" vim-plug: Vim plugin manager
" ============================
"
" 1. Download plug.vim and put it in 'autoload' directory
"
"   # Vim
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"   # Neovim
"   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"
" 2. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim)
"
"   call plug#begin()
"
"   " List your plugins here
"   Plug 'tpope/vim-sensible'
"
"   call plug#end()
"
" 3. Reload the file or restart Vim, then you can,
"
"     :PlugInstall to install plugins
"     :PlugUpdate  to update plugins
"     :PlugDiff    to review the changes from the last update
"     :PlugClean   to remove plugins no longer in the list
"
" For more information, see https://github.com/junegunn/vim-plug
"
"
" Copyright (c) 2024 Junegunn Choi
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

