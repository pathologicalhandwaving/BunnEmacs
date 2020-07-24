;;; init.el --- BunnEmacs Literate Config
;; Copyright (C) 2020 PathologicalHandwaving
;; Author: PathologicalHandwaving
;; Created: 2020-07-24
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

  (setq-default default-directory "/Users/emd/")

  ;; exec-path-from-shell
  (use-package exec-path-from-shell)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  
  ;; tangle config
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
  (garbage-collect))

;;; init.el ends here
