;;; init.el --- BunnEmacs Literate Config
;; Copyright (C) 2020 PathologicalHandwaving
;; Author: Kris Short <kristimshort@icloud.com>
;; Created: 2020-07-06
;; Homepage: https://pathologicalhandwaving.github.io
;; Keywords: emacs, latex, orgmode
;;
;;          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;                    Version 2, December 2004
;;
;; Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
;;
;;Everyone is permitted to copy and distribute verbatim or modified
;; copies of this license document, and changing it is allowed as long
;; as the name is changed.
;;
;;           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;;
;;0. You just DO WHAT THE FUCK YOU WANT TO.
;; <http://www.wtfpl.net/>
;;
;; Commentary:
;; Loads an org file, builds config out of it.
;;; Code:

;; garbage collection
(let ((gc-cons-percentage .6)
      (gc-cons-threshold most-positive-fixnum))

  ;; package repositories
  (require 'package)
  (setq-default
    load-prefer-newer t
    package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (package-initialize)

  ;; dependencies
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package t))
  (setq-default
    use-package-always-defer t
    use-package-always-ensure t)

  ;; latest orgmode
  (use-package org :ensure org-plus-contrib)

  ;; tangle config
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
  (garbage-collect))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(easy-kill zone-nyan yequake yasnippet-snippets yaml-mode wttrin writeroom-mode writegood-mode writefreely wotd world-time-mode wordsmith-mode wolfram wiki-nav whois which-key webpaste web-search web-mode wallpaper walkman w3m verb uuidgen uuid use-package underwater-theme uml-mode turing-machine tron-legacy-theme transwin transfer-sh transcribe tongbu toc-org tldr texfrag tex-smart-umlauts terminal-here term-run telega synosaurus sx switch-window switch-buffer-functions super-save stripes standard-dirs ssh-tunnels ssh-deploy ssh-agency ssass-mode spotlight spell-fu sound-wav sos somafm solaire-mode smex slack skewer-mode simple-bookmarks side-notes shut-up shroud shimbun shell-pop secretaria sdcv scratch-pop scratch scpaste scihub save-visited-files sass-mode rubik ripgrep rfc-mode repo remind-bindings register-quicknav recently read-aloud rainbow-mode rainbow-fart rainbow-delimiters racket-mode quiz python-x python-mode pylint prompt-text popup-switcher poporg pophint poet-theme podcaster plantuml-mode planet-theme pdfgrep pdf-view-restore parrot paperless ox-twbs ox-slack ox-rfc ox-latex-subfigure ox-json ox-jekyll-md ox-epub ox-clip outline-toc osx-pseudo-daemon osx-location osx-lib osx-dictionary osa-chrome orgtbl-join orgtbl-ascii-plot orgtbl-aggregate orglue orglink orgit org2jekyll org2issue org-working-set org-web-tools org-trello org-transform-tree-table org-taskforecast org-tanglesync org-table-sticky-header org-table-comment org-sync-snippets org-superstar org-special-block-extras org-sidebar org-shoplist org-reverse-datetree org-recent-headings org-preview-html org-plus-contrib org-picklink org-parser org-noter-pdftools org-multiple-keymap org-multi-wiki org-mime org-make-toc org-linkotron org-index org-id-cleanup org-generate org-download org-chef org-category-capture org-capture-pop-frame org-bullets org-books org-board org-autolist org-alert org-ac ordinal olivetti ob-translate ob-sql-mode ob-sml ob-rust ob-restclient ob-latex-as-png ob-http ob-html-chrome ob-graphql ob-go ob-elm ob-diagrams ob-cypher ob-browser ob-blockdiag ob-applescript nyan-mode nov noaa no-littering nimbus-theme neotree mybigword mw-thesaurus mu2tex mpdel mini-modeline mini-frame minesweeper metronome md4rd major-mode-icons magit-todos magit-org-todos magic-latex-buffer luarocks lolcat load-bash-alias linkode link-hint linguistic levenshtein legalese launchctl latexdiff latex-preview-pane latex-math-preview latex-extra labburn-theme lab-themes kaolin-themes jsonnet-mode jsonl jq-mode jeison jedi ivy-yasnippet ivy-todo ivy-posframe ivy-hydra ivy-historian ivy-clipmenu ivy-bibtex ivy-avy iplayer ipcalc interleave inkpot-theme imenu-list imenu-anywhere idomenu idle-org-agenda hnreader hackernews gscholar-bibtex grab-x-link google-maps google-contacts google gnuplot gitignore-mode github-stars github-review gitconfig-mode gitattributes-mode git-link git-gutter-fringe gif-screencast geolocation geoip gameoflife format-all flyspell-correct-popup flyspell-correct-ivy flymake-shellcheck flymake-racket flymake-json flymake-css flycheck-pos-tip flycheck-grammarly flycheck-clang-analyzer flx-ido fix-word fireplace fira-code-mode filetags figlet ffmpeg-player fancy-dabbrev exotica-theme exiftool exec-path-from-shell eshell-toggle ereader elsa elquery elpy elpl eloud editorconfig edit-server edit-chrome-textarea edbi ebuku ebib easy-jekyll doom-themes doom-modeline doom dockerfile-mode docker-cli docker-api docker djvu diminish digit-groups diff-hl dictionary dictcc desktop+ define-word define-it decide datetime dashboard-project-status dashboard-ls dashboard-hackernews cyberpunk-theme currency-convert curl-to-elisp csv-mode crux crontab-mode competitive-programming-snippets company-suggest company-restclient company-reftex company-quickhelp-terminal company-posframe company-math company-lua company-jedi company-emoji company-dict company-box company-bibtex company-auctex company-arduino code-library code-archive cobalt cloud-theme closql cliphist clang-format+ clang-capf citeproc-org chronometrist chronometer cheatsheet cheat-sh charmap char-menu centered-window centered-cursor-mode cdlatex cdb camcorder call-graph calfw-org calfw-ical calfw calc-at-point bug-reference-github browse-kill-ring bongo bog bibtex-utils bibslurp bibretrieve bibclean-format better-defaults bash-completion autobookmarks auto-package-update auto-dim-other-buffers audio-notes-mode auctex-lua auctex-latexmk async-await asx ascii-table arduino-cli-mode archive-region aqi apib-mode annotate amx all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired alarm-clock aio addressbook-bookmark activity-watch-mode ace-popup-menu academic-phrases ac-math ac-html ac-emoji ac-clang ac-c-headers abyss-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
