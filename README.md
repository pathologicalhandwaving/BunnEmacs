# BunnEmacs

``` text                                                                        
,-----.                          ,------.                                
|  |) /_ ,--.,--.,--,--, ,--,--, |  .---',--,--,--. ,--,--. ,---. ,---.  
|  .-.  \|  ||  ||      \|      \|  `--, |        |' ,-.  || .--'(  .-'  
|  '--' /'  ''  '|  ||  ||  ||  ||  `---.|  |  |  |\ '-'  |\ `--..-'  `) 
`------'  `----' `--''--'`--''--'`------'`--`--`--' `--`--' `---'`----'                                                                           
```

A literate Emacs configuration exclusively for MacOS which aims to solve various OS specific integration issues.

BunnEmacs uses emacsclient by default using a Hammerspoon launcher.


## Focus
  - LaTeX
  - Org-Mode
  - Jekyll
  - Git
  - Python
  - JSON
  - use-package

## Essential Packages
  - use-package
  - company
  - AucTeX
  - yasnippet
  - org-mode

## Essential Supporting Software
  - [Hammerspoon](https://www.hammerspoon.org/)
  - [Karabiner Elements](https://karabiner-elements.pqrs.org/)
  - [MacTeX](https://tug.org/mactex/)
  

## Installation

Licensed under [wtfpl](http://www.wtfpl.net/)

### Emacs

Installed on macOS Catalina using Emacs28 [davidrestivo/emacs-head](https://github.com/daviderestivo/homebrew-emacs-head)


``` bash
brew tap daviderestivo/emacs-head
brew install emacs-head@28 --with-cocoa

git clone https://github.com/pathologicalhandwaving/BunnEmacs.git ~/.emacs.d
```

### Flycheck

[Flycheck](https://github.com/flycheck/flycheck) linter
``` bash
npm i -g eslint
npm i -g jsonlint
pip3 install flake8
gem install scss_lint scss_lint_reporter_checkstyle
```

### Helm
use `rg` instead of `grep` to find files.

``` bash
brew install ripgrep
```

## Hammerspoon

``` lua
-- NUB ::
nub   = {"cmd", "shift"}

-- Launch or Focus Emacs
hs.hotkey.bind(nub, "E", function()
    hs.application.launchOrFocus("/usr/local/Cellar/emacs-head@28/28.0.50_1/Emacs.app")
end)
--
```

