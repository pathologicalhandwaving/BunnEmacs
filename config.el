(setq inhibit-startup-message t)

(setq-default initial-scratch-message "")

(menu-bar-mode +1)
(tool-bar-mode -1)
(tooltip-mode +1)

(scroll-bar-mode -1)
(setq scroll-margin 0
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(add-hook 'after-init-hook 'global-hl-line-mode)

(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)

(global-visual-line-mode t)

(modify-frame-parameters (selected-frame) '((alpha . 75)))
(add-to-list 'default-frame-alist '(alpha 85 85))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(add-hook 'focus-out-hook #'garbage-collect)

(setq large-file-warning-threshold 100000000)

(when (eq system-type 'darwin)
  (setq-default
   exec-path (append exec-path '("/usr/local/bin"))   ; homebrew path
   ns-command-modifier 'meta
   mac-option-modifier 'super                          ; super to ALT
   mac-right-option-modifier nil))                     ; disable right ALT

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :hook (after-init . exec-path-from-shell-initialize))

(fset 'yes-or-no-p 'y-or-n-p)

(setq require-final-newline t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(let ((secret.el (expand-file-name ".secret.el" user-emacs-directory)))
  (when (file-exists-p secret.el)
    (load secret.el)))

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
  (company-minimum-prefix-length 1)
  (company-require-match nil)
  (company-tooltip-align-annotations t))

(use-package define-word)

(use-package google-translate)

(use-package pdf-tools
  :pin manual
  :config
  (pdf-tools-install))

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

(use-package ielm
  :ensure nil
  :hook (ielm-mode . (lambda () (setq-local scroll-margin 0))))

(use-package python
  :ensure nil
  :hook (python-mode . turn-on-prettify-symbols-mode))

(use-package yaml-mode
  :mode ("\\.yml\\'"))
