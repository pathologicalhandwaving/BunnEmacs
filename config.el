(setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((secret.el (expand-file-name "secret.el" user-emacs-directory)))
  (when (file-exists-p secret.el)
    (load secret.el)))

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

(setq require-final-newline t)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(modify-frame-parameters (selected-frame) '((alpha . 75)))
(add-to-list 'default-frame-alist '(alpha 85 85))

(setq ns-function-modifer 'hyper)

(setq mac-option-modifer 'meta)
(setq mac-command-modifer 'super)

(use-package neotree
  :bind ("C-x n" . neotree-toggle)
  :config
  (setq neo-smart-open t))

(use-package all-the-icons)

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

(use-package nyan-mode
  :init
  :config
  (nyan-mode t)
  (nyan-toggle-wavy-trail)
  (nyan-start-animation))

(use-package rainbow-delimiters)

(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
				(other-window -1)))

(use-package helm
  :config
  (helm-mode 1))

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t)
(setq helm-recentf-fuzzy-match t)

(use-package semantic
  :config
  (semantic-mode 1))

(global-set-key (kbd "C-x C-m") 'helm-semantic-or-imenu)

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
         ("C-c f" . crux-recentf-find-file)
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

(use-package easy-kill)

(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key [remap mark-sexp] 'easy-mark)

(setq save-interprogram-paste-before-kill t)

(use-package wttrin
  :ensure t
  :commands (wttrin)
  :init
  (setq wttrin-default-cities '("Durham,NC")))

(setq auto-save-interval 30)

(setq backup-by-copying t)
(setq kept-new-versions 10)
(setq kept-old-versions 2)
(setq delete-old-versions t)
(setq version-control t)
(setq vc-make-backup-files t)

(setq initial-major-mode 'org-mode)

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(require 'org-tempo)

(use-package refTeX
  :config
  (setq reftex-default-bibliography '("~/Librarian/Bibliography/default.bib")))

(use-package org-ref
  :config
  (setq org-ref-default-bibliography '("~/Librarian/Bibliography/default.bib")
	org-ref-pdf-directory "~/Librarian/PDFs")

(use-package helm-bibtex
  :config
  (setq bibtex-completion-bibliography "~/Librarian/Bibliography/default.bib"
	bibtex-completion-library-path "~/Librarian/PDFs")

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

(setq org-highlight-latex-and-related '(latex bibtex))

(use-package ielm
  :ensure nil
  :hook (ielm-mode . (lambda () (setq-local scroll-margin 0))))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-confirm-babel-evaluate nil)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-src-preserve-indentation t)

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(setq org-list-demote-modify-bullet '(("-" . "+")
                                      ("+" . "*")
				      ("*" . "-")))

(setq org-hide-emphasis-markers t)

(setq org-fontify-whole-headline t)

(setq org-fontify-done-headline t)

(setq org-fontify-quote-and-verse-blocks t)

(setq org-deadline-warning-days 7)

(setq org-agenda-span 7)

(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

(setq org-directory "/Users/emd/OrgDB")

(setq org-agenda-files (list org-directory))

(setq org-default-notes-file (concat org-directory "/Notes/notes.org"))

(setq org-list-description-max-indent 5)

(use-package poporg
  :bind (("C-c /" . poporg-dwim)))

(use-package python
  :ensure nil
  :hook (python-mode . turn-on-prettify-symbols-mode))

(use-package yaml-mode
  :mode ("\\.yml\\'"))
