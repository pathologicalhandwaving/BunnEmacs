;;; init.el --- GNU Emacs Configuration

;; Copyright (C) 2014 Terencio Agozzino

;; Author: Terencio Agozzino <terencio.agozzino@gmail.com>
;; Created: February 16, 2014
;; Homepage: https://github.com/rememberYou/.emacs.d
;; Keywords: abbrev, convenience, faces, maint, outlines, vc

;; This program is free software. You can redistribute it and/or modify it under
;; the terms of the Do What The Fuck You Want To Public License, version 2 as
;; published by Sam Hocevar.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.
;;
;; You should have received a copy of the Do What The Fuck You Want To Public
;; License along with this program. If not, see http://www.wtfpl.net/.

;;; Commentary:

;; Following lines build the configuration code out of the config.el file.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; highlight current line
(global-hl-line-mode t)

;; line and column numbers
(line-number-mode t)

;; macos cmd is meta key
(setq mac-command-modifier 'meta)

;; package setup
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "https://orgmode.org/elpa/") t)

;;(unless package-archive-contents
;; (package-refresh-contents))
;;(setq package-load-list '(all))
;;(unless (package-installed-p 'org)
;;  (package-install 'org))
(package-initialize)


;; custom config file
(setq custom-file "~/.emacs.d/custom.el")

(load-file custom-file)

;; default theme
;;(load-theme doom-challenger-deep)


;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;; init.el ends here
