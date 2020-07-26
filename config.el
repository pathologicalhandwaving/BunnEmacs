(setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((secret.el (expand-file-name "secret.el" user-emacs-directory)))
  (when (file-exists-p secret.el)
    (load secret.el)))

(defun bun-set-initial-frame ()
  (let* ((base-factor 0.70)
         (a-width (* (display-pixel-width) base-factor))
         (a-height (* (display-pixel-height) base-factor))
         (a-left (truncate (/ (- (display-pixel-width) a-width) 2)))
         (a-top (truncate (/ (- (display-pixel-height) a-height) 2))))
    (set-frame-position (selected-frame) a-left a-top)
    (set-frame-size (selected-frame) (truncate a-width) (truncate a-height) t)))
(setq frame-resize-pixelwise t)
(bun-set-initial-frame)



(setq inhibit-startup-message t)

(setq-default initial-scratch-message "")

(menu-bar-mode +1)
(tool-bar-mode -1)
(tooltip-mode +1)

(size-indication-mode t)

(scroll-bar-mode -1)
(setq scroll-margin 3
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(add-hook 'after-init-hook 'global-hl-line-mode)

(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)

(global-visual-line-mode t)

(set-default 'truncate-lines nil)
(set-default 'word-wrap t)
(setq helm-buffers-truncate-lines nil)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(add-hook 'focus-out-hook #'garbage-collect)

(setq large-file-warning-threshold 100000000)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)

(setq require-final-newline t)

(progn
(setq org-confirm-babel-evaluate nil)
(setq org-confirm-elisp-link-function nil)
(setq org-confirm-shell-link-function nil))

(require 'cl-lib)
(use-package f :demand t)        ; files
(use-package dash :demand t)     ; lists
(use-package ht :demand t)       ; hash-tables
(use-package s :demand t)        ; strings
(use-package a :demand t)        ; association lists
(use-package anaphora :demand t) ; enables temp variables

(defvar bunny-home-dir (expand-file-name "~/"))
(defvar bunny-emacs-dir (concat bunny-home-dir ".emacs.d/"))
(defvar bunny-librarian (concat bunny-home-dir "Librarian/"))
(defvar bunny-pictures-dir (concat bunny-home-dir "Pictures/"))
(defvar bunny-movies-dir (concat bunny-home-dir "Movies/"))
(defvar bunny-music-dir (concat bunny-home-dir "Music/"))
(defvar bunny-progz-dir (concat bunny-home-dir "Progz/"))
(defvar bunny-repos-dir (concat bunny-home-dir "Repos/"))
(defvar bunny-sites-dir (concat bunny-home-dir "Sites/"))
(defvar bunny-torrents-dir (concat bunny-home-dir "Torrents/"))
(defvar bunny-org-dir (concat bunny-home-dir "OrgDB/"))

(defvar bunny-adhd-dir (concat bunny-org-dir "ADHD/"))
(defvar bunny-archive-dir (concat bunny-org-dir "Archive/"))
(defvar bunny-code-dir (concat bunny-org-dir "Code/"))
(defvar bunny-dmp-dir (concat bunny-org-dir "DMP/"))
(defvar bunny-invest-dir (concat bunny-org-dir "Investigations/"))
(defvar bunny-inbox-dir (concat bunny-org-dir "Inbox/"))
(defvar bunny-lldb-dir (concat bunny-org-dir "LLDB/"))
(defvar bunny-lists-dir (concat bunny-org-dir "Lists/"))
(defvar bunny-logs-dir (concat bunny-org-dir "Logs/"))
(defvar bunny-notes-dir (concat bunny-org-dir "Notes/"))
(defvar bunny-paperless-dir (concat bunny-org-dir "Paperless/"))
(defvar bunny-projects-dir (concat bunny-org-dir "Projects/"))
(defvar bunny-tmp-dir (concat bunny-org-dir "TMP/"))
(defvar bunny-templates-dir (concat bunny-org-dir "Templates/"))
(defvar bunny-work-dir (concat bunny-org-dir "Work/"))

(defvar bunny-articles-dir (concat bunny-librarian "Articles/"))
(defvar bunny-bib-dir (concat bunny-librarian "Bibliography/"))
(defvar bunny-data-dir (concat bunny-librarian "Data/"))
(defvar bunny-dictionary-dir (concat bunny-librarian "Dictionary/"))
(defvar bunny-legis-dir (concat bunny-librarian "Legis/"))
(defvar bunny-pdfs-dir (concat bunny-librarian "PDFs/"))
(defvar bunny-quotes-dir (concat bunny-librarian "Quotes/"))
(defvar bunny-text-dir (concat bunny-librarian "Text/"))
(defvar bunny-webarchives-dir (concat bunny-librarian "WebArchives/"))
(defvar bunny-epubs-dir (concat bunny-librarian "ePubs/"))

(defvar bunny-films-dir (concat bunny-movies-dir "Films/"))
(defvar bunny-lectures-dir (concat bunny-movies-dir "Lectures/"))
(defvar bunny-tv-dir (concat bunny-movies-dir "TV/"))
(defvar bunny-talks-dir (concat bunny-movies-dir "Talks/"))

(defvar bunny-audiobooks-dir (concat bunny-music-dir "AudioBooks/"))
(defvar bunny-songs-dir (concat bunny-music-dir "Music/"))
(defvar bunny-sounds-dir (concat bunny-music-dir "Sounds/"))

(defvar bunny-content-dir (concat bunny-sites-dir "Content/"))
(defvar bunny-devl-dir (concat bunny-sites-dir "Devl/"))
(defvar bunny-drafts-dir (concat bunny-sites-dir "Drafts/"))
(defvar bunny-production-dir (concat bunny-sites-dir "Production/"))

(defun bunny-org-file-name (file-name)
"Create file-name relative to bunny-org-dir"
(concat bunny-org-dir file-name))

(defun bunny-librarian-file-name (file-name)
"Create file-name relative to bunny-librarian directory"
(concat bunny-librarian file-name))

(defvar bunny-notes-file
(bunny-org-file-name "Notes/notes.org")
"Notes catcher file-name")

(defvar bunny-inbox-file
(bunny-org-file-name "Inbox/inbox.org")
"Inbox catcher file-name")

(defvar bunny-agenda-file
(bunny-org-file-name "Inbox/agenda.org")
"Agenda catcher file-name")

(defvar bunny-ideas-file
(bunny-org-file-name "Inbox/ideas.org")
"Ideas catcher file-name")

(defvar bunny-todos-file
(bunny-org-file-name "Inbox/todos.org")
"Todos catcher file-name")

(defvar bunny-recipes-file
(bunny-org-file-name "Inbox/recipes.org")
"Recipes file-name")

(defvar bunny-remember-file
(bunny-org-file-name "Inbox/remember.org")
"remember file-name")

(defvar bunny-routine-file
(bunny-org-file-name "Inbox/routine.org")
"routine file-name")

(defvar bunny-holidays-file
(bunny-org-file-name "Inbox/holidays.org")
"Holidays file-name")

(defvar bunny-log-file
(bunny-org-file-name "Logs/log.org")
"Log catcher file-name")

(defvar bunny-invest-file
(bunny-org-file-name "Investigations/investigations.org")
"Investigations list file-name")

(defvar bunny-lldb-file
(bunny-org-file-name "LLDB/lldb.org")
"LLDB file-name")

(defvar bunny-lists-index-file
(bunny-org-file-name "Lists/index.org")
"Lists index file-name")

(defvar bunny-project-list-file
(bunny-org-file-name "Projects/projects.org")
"Projects list file-name")

(defvar bunny-templates-index-file
(bunny-org-file-name "Templates/index.org")
"Templates index file-name")

(defvar bunny-observations-file
(bunny-org-file-name "Logs/observations.org")
"observations file-name")

(defvar bunny-pdfs-index-file
(bunny-librarian-file-name "PDFs/index.org")
"PDFs Index file-name")

(defvar bunny-articles-index-file
(bunny-librarian-file-name "Articles/index.org")
"Articles Index file-name")

(defvar bunny-data-index-file
(bunny-librarian-file-name "Data/index.org")
"Data Index file-name")

(defvar bunny-dictionary-index-file
(bunny-librarian-file-name "Dictionary/index.org")
"Dictionary Index file-name")

(defvar bunny-legis-index-file
(bunny-librarian-file-name "Legis/index.org")
"Legis Index file-name")

(defvar bunny-quotes-index-file
(bunny-librarian-file-name "Quotes/index.org")
"Quotes Index file-name")

(defvar bunny-text-index-file
(bunny-librarian-file-name "Text/index.org")
"Text Index file-name")

(defvar bunny-epubs-index-file
(bunny-librarian-file-name "ePubs/index.org")
"ePubs Index file-name")

(defvar bunny-elfeed-org-files
(bunny-librarian-file-name "feeds.org")
"feeds.org file-name")

(defvar bunny-adhd-log-file 
(bunny-org-file-name "ADHD/log.org")
"ADHD log file-name")

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(modify-frame-parameters (selected-frame) '((alpha . 75)))
(add-to-list 'default-frame-alist '(alpha 85 85))

(setq ns-function-modifer 'hyper)

(setq mac-option-modifer 'meta)
(setq mac-command-modifer 'super)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-neotree-config)
  (setq doom-neotree-enable-file-icons t)
  (setq doom-neotree-enable-chevron-icons t)
  (setq doom-neotree-enable-type-colors t)
  (doom-themes-org-config))

(load-theme 'doom-outrun-electric t)

(use-package neotree
  :bind ("C-x n" . neotree-toggle)
  :config
  (neotree-dir "~/.emacs.d"))

(global-set-key [f8] 'neotree-toggle)

(defun neotree-startup ()
  (interactive)
  (neotree-show)
  (call-interactively 'other-window))
(if (daemonp)
    (add-hook 'server-switch-hook #'neotree-startup)
  (add-hook 'after-init-hook #'neotree-startup))

(use-package all-the-icons)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(use-package nyan-mode
  :config
  (nyan-mode 1)
  (nyan-toggle-wavy-trail)
  (nyan-start-animation))

(use-package rainbow-delimiters)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
				(other-window -1)))

(global-set-key (kbd "C-x C-b") 'ibuffer)

(define-key global-map (kbd "C-c M-3") (lambda () (interactive) (insert "§")))

(define-key global-map (kbd "C-c M-4") (lambda () (interactive) (insert "↯")))

(global-set-key (kbd "C-x w") 'delete-frame)

(setq mouse-drag-copy-region t)

(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-c c") 'org-capture)

(global-set-key (kbd "C-c l") 'org-store-link)

(use-package help-mode
  :ensure nil
  :bind
  (:map help-mode-map
        ("<" . help-go-back)
        (">" . help-go-forward)))

(use-package eldoc
  :ensure nil
  :config
  (global-eldoc-mode -1))

(require 'dash-docs)
(setq dash-docs-browser-func 'eww)

(use-package helm
  :diminish
  :init (helm-mode t)
  :bind (("M-x" . helm-M-x)
	     ("C-x C-f" . helm-find-files)
	     ("C-x b" . helm-mini)
	     ("C-x C-r" . helm-recentf)
	     ("C-c i" . helm-imenu)
	     ("M-y" . helm-show-kill-ring)
	     ("C-c o" . helm-occur)
	     ("C-x r b" . helm-bookmarks)
	     ("C-c R" . helm-register))
  :config
  (helm-autoresize-mode 1))

(use-package helm-org
  :config
  (add-to-list 'helm-completing-read-handlers-alist '(org-capture . helm-org-completing-read-tags))
  (add-to-list 'helm-completing-read-handlers-alist '(org-set-tags . helm-org-completing-read-tags)))

(use-package helm-themes)

(use-package helm-descbinds
  :demand
  :config
  (helm-descbinds-mode))

(use-package helm-org-rifle
  :after (helm org)
  :commands helm-org-rifle-current-buffer
  :config
  (define-key org-mode-map (kbd "M-r") 'helm-org-rifle-current-buffer))

(require 'helm-ls-git)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-x r p") 'helm-projects-history)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

(use-package company
  :bind
  (:map company-active-map
        ("RET" . nil)
        ([return] . nil)
        ("TAB" . company-complete-selection)
        ([tab] . company-complete-selection)
        ("<right>" . company-complete-common))
  :hook
  (after-init . global-company-mode)
  :custom
  (company-dabbrev-downcase nil)
  (company-idle-delay .2)
  (company-minimum-prefix-length 2)
  (company-tooltip-limit 10)
  (company-show-numbers t)
  (company-require-match nil)
  (company-tooltip-align-annotations t)
  (company-tooltip-flip-when-above t))

(global-company-mode 1)

(use-package which-key
  :config
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-frame-max-height 20)
  (which-key-mode +1))

(use-package smex
  :bind
  ("M-x" . 'smex)
  ("M-X" . 'smex-major-mode-commands)
  :config
  (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  (smex-initialize))

(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)
	     ("C-c u" . crux-view-url)
	     ("C-c k" . crux-kill-other-buffers)
	     ("C-c i" . crux-ispell-word-then-abbrev)
	     ("C-x C-u" . crux-upcase-region)
	     ("C-x C-l" . crux-downcase-region)
	     ("C-c r" . crux-rename-file-and-buffer)
	     ("C-c D" . crux-delete-file-and-buffer)
	     ("C-k" . crux-smart-kill-line)))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)
(setq abbrev-file-name "~/.emacs.d/abbreviations.el")
(quietly-read-abbrev-file)

(use-package define-word)

(use-package google-translate)

(require 'git-gutter)
(global-git-gutter-mode +1)
(global-set-key (kbd "C-x C-g") 'git-gutter)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
(add-to-list 'git-gutter:update-hooks 'focus-in-hook)

(require 'git-auto-commit-mode)
(setq-default gac-automatically-push-p t)

(require 'org-attach-git)

(require 'helm-github-stars)
(setq helm-github-stars-username "pathologicalhandwaving")
(setq helm-github-stars-refetch 10.0)
(setq helm-github-stars-name-length 17)

(use-package rfc-mode
  :init
  (setq rfc-mode-directory (expand-file-name "~/Librarian/Dictionary/RFCs/")
        rfc-mode-index-path (concat rfc-mode-directory "rfc-index.org")))

(use-package pdf-tools
  :pin manual
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
  (setq pdf-view-resize-factor 1.1)
  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)
  (with-eval-after-load "pdf-annot"
    (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
    (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)
    (advice-add 'pdf-annot-edit-contents-commit :after 'emd/save-buffer-no-args)))

(use-package org-pdftools
  :hook (org-load . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package ebuku)

(use-package bm
  :bind (("<C-f2>" . bm-toggle)
         ("<f2>" . bm-next)
	 ("<S-f2>" . bm-previous)))

(with-eval-after-load 'helm
(require 'helm-bookmark)
(global-set-key (kbd "C-x C-b") 'helm-bookmark))

(setq ebuku-buku-path "/usr/local/bin/buku")
(setq ebuku-database-path "/Users/emd/.local/share/buku/bookmarks.db")

(use-package easy-kill)

(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key [remap mark-sexp] 'easy-mark)

(setq save-interprogram-paste-before-kill t)

(use-package wttrin
  :ensure t
  :commands (wttrin)
  :init
  (setq wttrin-default-cities '("Durham,NC")))

(setq auto-save-default t)

(setq auto-save-timeout 30)

(setq auto-save-interval 30)

(defvar emacs-autosave-directory
(concat user-emacs-directory "autosaves/"))
(unless (file-exists-p emacs-autosave-directory)
(make-directory emacs-autosave-directory))

(setq backup-directory-alist `((".*" . ,emacs-autosave-directory)))

(setq backup-by-copying t)
(setq kept-new-versions 10)
(setq kept-old-versions 0)
(setq delete-old-versions t)
(setq version-control t)
(setq vc-make-backup-files t)

(use-package backup-each-save
  :config (add-hook 'after-save-hook 'backup-each-save))

(setq initial-major-mode 'org-mode)

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(require 'chronos)

(use-package helm-chronos
  :ensure t
  :init (setq helm-chronos-standard-timers
              '("       5/Coffee"
                "       30/Shower"
                "       25/Email"
                "       27/Pom: Work + 7/Pom: Rest"))
  :bind (("C-c t" . helm-chronos-add-timer)))

(require 'alarm-clock)

(require 'org-tempo)

(use-package css-mode
  :ensure nil
  :custom (css-indent-offset 2))

(use-package scss-mode
  :ensure nil
  :preface
  (defun bunny/scss-set-comment-style ()
    (setq-local comment-end "")
    (setq-local comment-start "//"))
  :mode ("\\.sass\\'" "\\.scss\\'")
  :hook (scss-mode . bunny/scss-set-comment-style))

(use-package csv-mode)

(use-package rainbow-mode
  :custom
  (rainbow-x-colors-major-mode-list '()))

(use-package newcomment
  :ensure nil
  :bind
  ("<M-return>" . comment-indent-new-line)
  :custom
  (comment-auto-fill-only-comments t)
  (comment-multi-line t))

(use-package ediff-wind
  :ensure nil
  :custom
  (ediff-split-window-function #'split-window-horizontally)
  (ediff-window-setup-function #'ediff-setup-windows-plain))

(use-package sgml-mode
  :ensure nil
  :preface
  (defun bunny/html-set-pretty-print-function ()
    (setq bunny/pretty-print-function #'sgml-pretty-print))
  :hook
  ((html-mode . bunny/html-set-pretty-print-function)
   (html-mode . sgml-electric-tag-pair-mode)
   (html-mode . sgml-name-8bit-mode)
   (html-mode . toggle-truncate-lines))
  :custom
  (sgml-basic-offset 2))

(use-package json-mode
  :mode "\\.json\\'"
  :preface
  (defun bunny/json-set-indent-level ()
    (setq-local js-indent-level 2))
  :hook (json-mode . bunny/json-set-indent-level))

(setenv "PATH" (concat ":/Library/TeX/texbin/" (getenv "PATH")))
(add-to-list 'exec-path "/Library/TeX/texbin/")

(setq org-highlight-latex-and-related '(latex bibtex))

(use-package ielm
  :ensure nil
  :hook (ielm-mode . (lambda () (setq-local scroll-margin 0))))

(setq org-directory "~/OrgDB")
(setq org-default-notes-file (concat org-directory "/Notes/notes.org"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(require 'org-indent)
(setq org-startup-indented t)

(setq org-startup-truncated nil)

(setq org-startup-folded t)

(setq org-archive-location "~/OrgDB/Archive/agenda.org_archive::datetree/* Completed Tasks")

(defun bun-create-notes-file ()
"Create an org file in ~/OrgDB/Notes."
  (interactive)
  (let ((name (read-string "File Name: ")))
    (expand-file-name (format "%s.org" name) "~/OrgDB/Notes/")))

(setq org-capture-templates
  '(("t" "ToDo" entry (file+headline "~/OrgDB/Inbox/todos.org" "ToDos")
     "** TODO %?\n")
    ("a" "Appointment" entry (file+headline "~/OrgDB/Inbox/agenda.org" "Appointments")
     "** APPOINTMENT %?\n %a")
    ("c" "Cookbook" entry (file "~/OrgDB/Chef/cookbook.org")
     "** %^{Recipe Title: }\n   :PROPERTIES:\n   :URL:\n   :SERVINGS:\n   :PREP_TIME:\n   :COOK_TIME:\n  :END:\n*** Ingredients\n    %?\n*** Directions\n\n")
    ("n" "Note" entry (file+headline "~/OrgDB/Notes/notes.org" "Notes")
     "** NOTE %x\n   :PROPERTIES:\n   :DATE: %U\n   :END:\n" :empty-lines 1)))

(setq org-descriptive-links t)

(use-package org-chef
  :ensure t)

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(setq org-list-demote-modify-bullet '(("-" . "+")
                                      ("+" . "*")
				      ("*" . "-")))

(setq org-hide-emphasis-markers t)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-src-preserve-indentation t)

(setq org-fontify-whole-headline t)

(setq org-fontify-done-headline t)

(setq org-fontify-quote-and-verse-blocks t)

(setq org-list-description-max-indent 5)

(setq org-checkbox-hierarchical-statistics nil)

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
	      (sequence "FIXME" "|" "FIXED")
        (sequence "ADD" "|" "ADDED")
        (sequence "REMOVE" "|" "REMOVED")
        (sequence "MOVE" "|" "MOVED")))

(setq org-deadline-warning-days 7)

(setq org-agenda-span 7)

(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

(setq org-directory "/Users/emd/OrgDB/")

(setq org-agenda-files (list org-directory))

(setq org-default-notes-file (concat org-directory "/Notes/notes.org"))

(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-targets '((nil :maxlevel . 9)
			         (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path '(file))

(use-package poporg
  :bind (("C-c /" . poporg-dwim)))

(use-package python
  :ensure nil
  :hook (python-mode . turn-on-prettify-symbols-mode))

(use-package yaml-mode
  :mode ("\\.yml\\'"))
