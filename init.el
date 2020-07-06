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
(setq gc-cons-threshold 50000000)

;; get current user info
(defvar current-user
  (getenv
    (if (equal system-type 'darwin) "USERNAME" "USER")))

(message "BunnEmacs is gathering carrots... Wait here, %s!" current-user)

;; load newest byte code
(setq load-prefer-newer t)

;; No Startup Message
(setq inhibit-startup-message t)
;; Scratch Message
(setq initial-scratch-message "")

;; No toolbar
;; Yes menubar
(tool-bar-mode -1)
(menu-bar-mode +1)

;; no scroll bar
(scroll-bar-mode -1)
;; Dont scroll to zero and preserve screen position
(setq scroll-margin 0
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; no blinking cursor
(blink-cursor-mode -1)

;; highlight current line
(global-hl-line-mode +1)
;; line numbers
(line-number-mode +1)
(global-display-line-numbers-mode 1)
;; column numbers
(column-number-mode t)

;; display size of buffer
(size-indication-mode t)

;; macos cmd is meta key
(setq mac-command-modifier 'meta)

;; package management
(require 'package)
(setq package-enable-at-startup nil)
;; we dont need file handlers at startup
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
;; disable site-run-file
(setq site-run-file nil)

;; package archives
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(unless package-archive-contents
  (package-refresh-contents))
(setq package-load-list '(all))
(unless (package-installed-p 'org)
  (package-install 'org))


;; encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-language-environment "UTF-8")


;; Personal Config Directory
;;(defun update-to-load-path (folder)
;;  "Update FOLDER and subdirectories to `load-path`."
;;  (let ((base folder))
;;    (unless (member base load-path)
;;      (add-to-list 'load-path base))
;;    (dolist (f (directory-files base))
;;      (let ((name (concat base "/" f)))
;;        (when (and (file-directory-p name)
;;                   (not (equal f ".."))
;;                   (not (equal f ".")))
;;          (unless (member base load-path)
;;            (add-to-list 'load-path name)))))))
;;(update-to-load-path (expand-file-name "personal" user-emacs-directory))

;; set custom.el file location
;;(setq custom-file (concat user-emacs-directory "custom.el"))
;;(load custom-file 'noerror)


;; Add load-path variables
(defvar bunny-dir (file-name-directory load-file-name)
  "The root directory of BunnEmacs distribution.")
(defvar bunny-core-dir (expand-file-name "core" bunny-dir)
  "BunnEmacs core functionality")
(defvar bunny-modules-dir (expand-file-name "modules" bunny-dir)
  "Home for BunnEmacs modules.")
(defvar bunny-personal-dir (expand-file-name "personal" bunny-dir)
  "Directory for personal configuration.")
(defvar bunny-vendor-dir (expand-file-name "vendor" bunny-dir)
  "Directory for packages not available on Elpa or Melpa.")
(defvar bunny-savefile-dir (expand-file-name "savefile" bunny-dir)
  "Directory to store history-files.")
(defvar bunny-modules-file (expand-file-name "bunny-modules.el" bunny-personal-dir)
  "List of modules to be loaded by BunnEmacs.")

(unless (file-exists-p bunny-savefile-dir)
  (make-directory bunny-savefile-dir))

(defun bunny-add-subfolders-to-load-path (parent-dir)
  "Add all level PARENT-DIR subdirs to the `load-path`."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)
        (bunny-add-subfolders-to-load-path name)))))

;; add BunnEmacs directories to `load-path`
(add-to-list 'load-path bunny-core-dir)
(add-to-list 'load-path bunny-modules-dir)
(add-to-list 'load-path bunny-vendor-dir)
(bunny-add-subfolders-to-load-path bunny-vendor-dir)


;; core
;; Reduce garbage collection to every 50MB of allocated data
(setq gc-cons-threshold 50000000)

;; warn when opening files larger than 100MB
(setq large-file-warning-threshold 100000000)

(message "Loading BunnEmacs...")

;; core stuff
(require 'bunny-packages)
(require 'bunny-custom) ;; load before core, editor, and ui
(require 'bunny-ui)
(require 'bunny-core)
(require 'bunny-mode)
(require 'bunny-editor)
(require 'bunny-global-keybindings)

;; Modules
(if (file-exists-p bunny-modules-file)
  (load bunny-modules-file)
  (message "Missing modules file %s" bunny-modules-file))

;; Changes made using customize in UI are stored here
(setq custom-file (expand-file-name "custom.el" bunny-personal-dir))

;; load personal settings
(when (file-exists-p bunny-personal-dir)
  (message "Loading personal config files in %s..." bunny-personal-dir)
  (mapc 'load (delete
                bunny-modules-file
                (directory-files bunny-personal-dir 't "^[^#\.].\\.el$"))))

;; server
(unless (server-running-p) (server-start))

(message "BunnEmacs is ready to go %s! Stupid rabbit" current-user)

;;; init.el ends here
