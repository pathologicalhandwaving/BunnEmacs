;;; init.el --- Init
(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; highlight current line
(global-hl-line-mode t)

;; line and column numbers
(line-number-mode t)

;; macos cmd is meta key
(setq mac-command-modifier `meta)

;; package repos
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; custom config file
(setq custom-file "~/.emacs.d/custom.el")

(load-file custom-file)

;; default theme
;;(load-theme doom-challenger-deep)