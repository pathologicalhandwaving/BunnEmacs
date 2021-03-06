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

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (setq golden-ratio-max-width 72))

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

(load-theme 'doom-nord t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay 0.5
          treemacs-directory-name-transformer #'identity
          treemacs-display-in-side-window t
          treemacs-eldoc-display t
          treemacs-file-event-delay 5000
          treemacs-file-extension-regex treemacs-last-period-regex-value
          treemacs-file-follow-delay 0.2
          treemacs-file-name-transformer #'identity
          treemacs-follow-after-init t
          treemacs-git-command-pipe ""
          treemacs-goto-tag-strategy 'refetch-index
          treemacs-indentation 2
          treemacs-indentation-string " "
          treemacs-is-never-other-window nil
          treemacs-max-git-entries 5000
          treemacs-missing-project-action 'ask
          treemacs-moce-forward-on-expand nil
          treemacs-no-png-images nil
          treemacs-no-delete-other-windows t
          treemacs-project-follow-cleanup nil
          treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position 'left
          treemacs-recenter-distance 0.1
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow nil
          treemacs-show-cursor nil
          treemacs-show-hidden-files t
          treemacs-silent-filewatch nil
          treemacs-silent-refresh nil
          treemacs-sorting 'alphabetic-asc
          treemacs-space-between-root-nodes t
          treemacs-tag-follow-cleanup t
          treemacs-tag-follow-delay 1.5
          treemacs-user-mode-line-format nil
          treemacs-user-header-line-format nil
          treemacs-width 35
          treemacs-workspace-switch-cleanup nil)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0" . treemacs-select-window)
        ("C-x t 1" . treemacs-delete-other-windows)
        ("C-x t t" . treemacs)
        ("C-x t B" . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-all-the-icons)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

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

(require 'helm-config)

(require 'helm-icons)
(helm-icons-enable)

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

(require 'map)
(require 'org)
(require 'seq)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(defvar company-org-block-bol-p t
"If t, detect completion when at begining of line, otherwise detect completion anywhere.")

(defvar company-org--regexp "<\\([[^ ]*\\)")

(defun company-org-block (command &optional arg &rest ignore)
  "Complete org babel languages into source blocks."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-org-block))
    (prefix (when (derived-mode-p 'org-mode)
              (company-org-block--grab-symbol-cons)))
    (candidates (company-org-block--candidates arg))
    (post-completion
     (company-org-block--expand arg))))

(defun company-org-block--candidates (prefix)
  "Return a list of org babel languages matching PREFIX."
  (seq-filter (lambda (language)
                (string-prefix-p prefix language))
              ;; Flatten `org-babel-load-languages' and
              ;; `org-structure-template-alist', join and sort.
              (seq-sort
               #'string-lessp
               (append
                (mapcar #'prin1-to-string
                        (map-keys org-babel-load-languages))
                (map-values org-structure-template-alist)))))

(defun company-org-block--template-p (template)
  (seq-contains (map-values org-structure-template-alist)
                template))

(defun company-org-block--expand (insertion)
  "Replace INSERTION with actual source block."
  (delete-region (point) (- (point) (1+ ;; Include "<" in length.
                                     (length insertion))))
  (if (company-org-block--template-p insertion)
      (company-org-block--wrap-point insertion
                                     ;; May be multiple words.
                                     ;; Take the first one.
                                     (nth 0 (split-string insertion)))
    (company-org-block--wrap-point (format "src %s" insertion)
                                   "src")))

(defun company-org-block--wrap-point (begin end)
  "Wrap point with block using BEGIN and END.  For example:
#+begin_BEGIN
  |
#+end_END"
  (insert (format "#+begin_%s\n" begin))
  (insert (make-string org-edit-src-content-indentation ?\s))
  ;; Saving excursion restores point to location inside code block.
  (save-excursion
    (insert (format "\n#+end_%s" end))))

(defun company-org-block--grab-symbol-cons ()
  "Return cons with symbol and t whenever prefix of < is found.
For example: \"<e\" -> (\"e\" . t)"
  (when (looking-back (if company-org-block-bol-p
                          (concat "^" company-org--regexp)
                        company-org--regexp)
                      (line-beginning-position))
    (cons (match-string-no-properties 1) t)))

(add-to-list 'company-backends 'company-org-block)
(company-mode +1)

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

(use-package google-this
  :config
  (google-this-mode 1))

(require 'cheatsheet)
(global-set-key (kbd "C-x C-h") 'cheatsheet-show)

(cheatsheet-add-group 'cheats
                      '(:key "C-x C-h" :description "Show Cheatsheet")
                      '(:key "C-q" :description "Close Cheatsheet"))

(cheatsheet-add-group 'windows
                      '(:key "C-x o" :description "Goto other window")
                      '(:key "C-x w" :description "Delete Frame")
                      '(:key "C-x 5 2" :description "New Frame")
                      '(:key "C-x 3" :description "New window right")
                      '(:key "C-x 2" :description "New window below")
                      '(:key "C-x 1" :description "Close all but current window"))

(cheatsheet-add-group 'buffers
                      '(:key "C-x b" :description "Switch to buffer")
                      '(:key "C-x b named" :description "Create named buffer")
                      '(:key "C-x 4 b name" :description "Create in other window")
                      '(:key "C-x b" :description "Buffer menu")
                      '(:key "C-x k" :description "Kill buffer")
                      '(:key "C-c r" :description "Rename file and buffer")
                      '(:key "C-c D" :description "Delete file and buffer")
                      '(:key "C-c i" :description "iMenu"))

(cheatsheet-add-group 'neotree
                      '(:key "F8" :description "Neotree toggle"))

(cheatsheet-add-group 'bookmarks
                      '(:key "C-x C-b" :description "helm bookmark")
                      '(:key "C-f2" :description "marks toggle")
                      '(:key "f2" :description "marks next")
                      '(:key "S-f2" :description "marks previous"))

(cheatsheet-add-group 'moves
                      '(:key "C-f" :description "Forward Character")
                      '(:key "C-b" :description "Back Character")
                      '(:key "M-f" :description "Forward Word")
                      '(:key "M-b" :description "Back Word")
                      '(:key "M-a" :description "Forward Sentence")
                      '(:key "M-e" :description "Back Sentence")
                      '(:key "C-n" :description "Next Line")
                      '(:key "C-p" :description "Previous Line")
                      '(:key "C-a" :description "Beginning of Line")
                      '(:key "C-e" :description "End of Line")
                      '(:key "M-v" :description "Move by Screen")
                      '(:key "C-x ]" :description "Top of Buffer")
                      '(:key "C-x [" :description "Bottom of Buffer")
                      '(:key "C-x l" :description "Center Screen Here")
                      '(:key "C-c o" :description "Occur"))

(cheatsheet-add-group 'transform
                      '(:key "C-c i" :description "ispell word then abbrev")
                      '(:key "C-x C-u" :description "Uppercase")
                      '(:key "C-x C-l" :description "Lowercase")
                      '(:key "C-c M-3" :description "insert section symbol")
                      '(:key "C-c M-4" :description "insert contra symbol"))

(cheatsheet-add-group 'files
                      '(:key "C-x C-f" :description "Find File")
                      '(:key "C-x C-s" :description "Save File")
                      '(:key "C-x C-r" :description "Recent Files")
                      '(:key "C-x i" :description "Insert File")
                      '(:key "C-c u" :description "View url")
                      '(:key "C-c R" :description "Register"))

(cheatsheet-add-group 'edits 
                      '(:key "M-y" :description "Show kill ring")
                      '(:key "C-y" :description "Yank (Paste)")
                      '(:key "M-w" :description "Copy")
                      '(:key "C-w" :description "Cut")
                      '(:key "C-k" :description "Kill line")
                      '(:key "C-_" :description "Undo")
                      '(:key "M-_" :description "Redo"))

(cheatsheet-add-group 'git
                      '(:key "C-x C-d" :description "Browse project")
                      '(:key "C-x r p" :description "Projects history"))

(cheatsheet-add-group 'pdftools
                      '(:key "h" :description "highlight")
                      '(:key "t" :description "text")
                      '(:key "D" :description "delete")
                      '(:key "<return>" :description "edit annotation")
                      '(:key "<S-return>" :description "newline")
                      '(:key "C-s" :description "search forward"))

(cheatsheet-add-group 'orgmode
                      '(:key "C-c c" :description "Org Capture Menu")
                      '(:key "C-c a" :description "Org Agenda Menu")
                      '(:key "C-c l" :description "Org Store Link")
                      '(:key "C-c $" :description "Archive to file")
                      '(:key "M-r" :description "org-rifle"))

(cheatsheet-add-group 'utils
                      '(:key "C-c s" :description "Engine Mode Prefix")
                      '(:key "M-x n" :description "Side notes toggle")
                      '(:key "C-c /" :description "poporg")
                      '(:key "M-return" :description "Comment"))

(require 'engine-mode)
(engine-mode t)
(setq engine/browser-function 'eww-browse-url)
(engine/set-keymap-prefix (kbd "C-c s"))

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s")
(defengine ctan
  "http://www.ctan.org/search/?x=1&PORTAL=on&phrase=%s"
  :docstring "Search the Comprehensive TeX Archive Network (ctan.org)")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")
(defengine google-images
  "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s")
(defengine google-maps
  "http://maps.google.com/maps?q=%s"
  :docstring "Mapssss")
(defengine project-gutenberg
  "http://www.gutenberg.org/ebooks/search/?query=%s")
(defengine rfcs
  "http://pretty-rfc.herokuapp.com/search?q=%s")
(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s")
(defengine twitter
  "https://twitter.com/search?q=%s")
(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w")
(defengine wiktionary
  "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s")
(defengine wolfram-alpha
  "http://www.wolframalpha.com/input/?i=%s")
(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s")
(defengine seasoned-advice
  "https://cooking.stackexchange.com/search?q=%s")
(defengine mathematics
  "https://math.stackexchange.com/search?q=%s")
(defengine englang
  "https://english.stackexchange.com/search?q=%s")
(defengine linux
  "https://unix.stackexchange.com/search?q=%s")
(defengine infosec
  "https://security.stackexchange.com/search?q=%s")
(defengine cryptography
  "https://crypto.stackexchange.com/search?q=%s")
(defengine history
  "https://history.stackexchange.com/search?q=%s")
(defengine mathoverflow
  "https://mathoverflow.net/search?q=%s")
(defengine emacs
  "https://emacs.stackexchange.com/search?q=%s")
(defengine law
  "https://law.stackexchange.com/search?q=%s")
(defengine politics
  "https://politics.stackexchange.com/search?q=%s")
(defengine tcs
  "https://cstheory.stackexchange.com/search?q=%s")
(defengine merck
  "https://www.merckmanuals.com/professional/SearchResults?query=%s")
(defengine rosettacode
  "http://rosettacode.org/mw/index.php?title=Special%3ASearch&search=%s")
(defengine arxiv
  "https://arxiv.org/search/?query=%s")
(defengine citeseerx
  "https://citeseerx.ist.psu.edu/search?q=%s")
(defengine dblp
  "https://dblp.org/search?q=%s")
(defengine semanticscholar
  "https://www.semanticscholar.org/search?q=%s")
(defengine worldcat
  "https://www.worldcat.org/search?q=%s")
(defengine scholarpedia
  "http://www.scholarpedia.org/w/index.php?search=%s")
(defengine mathency
  "https://encyclopediaofmath.org/index.php?title=Special%3ASearch&search=%s")
(defengine mathworld
  "https://mathworld.wolfram.com/search/?query=%s")
(defengine oeis
  "https://oeis.org/search?q=%s")
(defengine nlab
  "https://www.google.com/search?as_q=%s&as_sitesearch=https%3A%2F%2Fncatlab.org%2Fnlab%2F")
(defengine sep
  "https://plato.stanford.edu/search/searcher.py?query=%s")
(defengine ballotpedia
  "https://ballotpedia.org/wiki/index.php?search=%s")
(defengine foldoc
  "https://foldoc.org/%s")
(defengine etymolonline
  "https://www.etymonline.com/search?q=%s")
(defengine jurispedia
  "http://www.jurispedia.org/index2.php?cof=FORID%3A11&ie=UTF-8&q=%s")
(defengine wikibooks
  "https://en.wikibooks.org/wiki/Special:Search?search=%s")
(defengine wikidata
  "https://www.wikidata.org/w/index.php?search=sseech&search=%s")
(defengine wikicommons
  "https://commons.wikimedia.org/w/index.php?search=%s")
(defengine wikinews
  "https://en.wikinews.org/wiki/Special:Search?search=%s")
(defengine wikiquote
  "https://en.wikiquote.org/wiki/Special:Search?search=%s")
(defengine wikisource
  "https://wikisource.org/w/index.php?search=%s")
(defengine wikiversity
  "https://en.wikiversity.org/wiki/Special:Search?search=%s")
(defengine wikitionary
  "https://en.wiktionary.org/wiki/Special:Search?search=%s")

(require 'gitignore-templates)
(setq gitignore-templates-api 'github)

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

(use-package ebuku)

(use-package bm
  :bind (("<C-f2>" . bm-toggle)
         ("<f2>" . bm-next)
	       ("<S-f2>" . bm-previous)))

(with-eval-after-load 'helm)
(require 'helm-bookmark)
(global-set-key (kbd "C-x C-b") 'helm-bookmark)

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
                "       27/Pom: Work + 7/Pom: Rest")))

(require 'alarm-clock)

(require 'org-tempo)

(require 'zen-mode)

(require 'outline-toc)

(require 'side-notes)
(global-set-key (kbd "M-s n") #'side-notes-toggle-notes)

(require 'md4rd)
(add-hook 'md4rd-mode-hook 'md4rd-indent-all-the-lines)

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

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(require 'org-indent)
(setq org-startup-indented t)

(setq org-startup-truncated nil)

(setq org-startup-folded t)

(require 'org-gcal)
(setq org-gcal-client-id "665892281799-neavl78mkd8v47ng50dpdanii7j42rkv.apps.googleusercontent.com"
      org-gcal-client-secret "G3-17CMyU-2x3oCDP-I40ZTO"
      org-gcal-fetch-file-alist '(("kms.orgsync@gmail.com" ~/OrgDB/Inbox/agenda.org)))

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
     "** APPOINTMENT %?\n" :empty-lines 1)
    ("c" "Cookbook" entry (file "~/OrgDB/Chef/cookbook.org")
     "** %^{Recipe Title: }\n   :PROPERTIES:\n   :URL:\n   :SERVINGS:\n   :PREP_TIME:\n   :COOK_TIME:\n  :END:\n*** Ingredients\n    %?\n*** Directions\n\n" :empty-lines 1)
    ("n" "Note" entry (file+headline "~/OrgDB/Notes/notes.org" "Notes")
     "** NOTE %x\n   :PROPERTIES:\n   :DATE: %U\n   :END:\n" :empty-lines 1)
    ("i" "Dictionary" entry (file+headline "Dictionary")
     "*** <<<%^{Term}>>> :: \n    :PROPERTIES:\n    :CATEGORY: %^{Index Letter}\n    :TAGS: %g\n    :END:\n    %^{Description}" :empty-lines 1)
    ("l" "Log" entry (file+datetree "~/OrgDB/Logs/log.org")
     "* %U: %^{Task Completed} %^g")
    ("d" "ADHD Log" entry (file+datetree "~/OrgDB/ADHD/log.org")
    "* %U : %^{Description}\n - %?")
    ("h" "Hyperfocus Log" entry (file+datetree "~/OrgDB/ADHD/hyperfocus-log.org")
     "* %U: \n - Behavior: %^{What did hyperfocus behavior look like?}\n - What: %^{What did I focus on?}\n - Duration: %^{How long did it last?}\n - Where: %^{Location occured?}\n - Known: %^{During the episode was I aware I was hyperfocused?}\n - Breaks: %^{Did I take any breaks?}\n - Thoughts: %^{What thoughts did I have after?}\n - Physical: %^{Physical symptoms after?}\n - Satisfaction: %^{From 1-10 how satisfied am I with what I did?}")
    ("e" "Census Log" entry (file+datetree "~/OrgDB/Work/Census/2020/log.org")
     "* %U: %^{Action}\n - %?")))

(setq org-descriptive-links t)

(use-package org-chef
  :ensure t)

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-list-demote-modify-bullet '(("-" . "+")
                                      ("+" . "*")
				      ("*" . "-")))

(setq org-hide-emphasis-markers t)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 2)
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

(setq org-directory '("/Users/emd/OrgDB"))

(setq org-agenda-files '("~/OrgDB/Inbox/todos.org" "~/OrgDB/Inbox/agenda.org" "~/OrgDB/Inbox/inbox.org"))

(setq org-default-notes-file '("~/OrgDB/Notes/notes.org"))

(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path '(file))

(use-package poporg
  :bind (("C-c /" . poporg-dwim)))

(require 'org-sidebar)
(require 'org-ql)

(require 'org-download)
(setq-default org-download-image-dir "~/OrgDB/Notes")

(require 'org-web-tools)

(require 'org-kanban)

(require 'org-books)
(setq org-books-file '("~/Librarian/index.org"))

(require 'org-ref)
(setq reftex-default-bibliography '("~/Librarian/Bibliography/default.bib"))
(setq org-ref-bibliography-notes '("~/Librarian/Annotations/annotations.org"))
(setq org-ref-default-bibliography '("~/Librarian/Bibliography/default.bib"))
(setq org-ref-pdf-directory '("~/Librarian/PDFs"))

(use-package org-noter
  :ensure t
  :after org
  :config
  (setq org-noter-default-notes-file-names '("~/Librarian/Annotations/annotations.org")
        org-noter-notes-search-path '("~/Librarian/Annotations"))
  (setq org-noter-separate-notes-from-heading t))

(defun org-ref-note-at-point ()
  "Open odf for citekey under point if exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (funcall org-ref-get-pdf-filename-function key)))
    (if (file-exists-p pdf-file)
        (progn
          (find-file-other-window pdf-file)
          (org-noter))
      (message "No pdf found for %s" key))))
(add-to-list 'org-ref-helm-user-candidates
             '("Annotations" . org-ref-note-at-point))

(require 'helm-bibtex)
(setq bibtex-completion-bibliography "~/Librarian/Bibliography/default.bib")
(setq bibtex-completion-library-path "~/Librarian/PDFs")
(setq bibtex-completion-notes-path "~/Librarian/Annotations")

(require 'doi-utils)

(defun bun-save-buffer-no-args ()
  "Save buffer ignoring arguments."
  (save-buffer))

(use-package pdf-tools
  :pin manual
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
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
    (advice-add 'pdf-annot-edit-contents-commit :after 'bun-save-buffer-no-args)))

(use-package org-pdftools
  :hook (org-load . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(add-to-list 'load-path "~/.emacs.d/vendor/pdf-tools-org.el")
(require 'pdf-tools-org)
(add-hook 'after-save-hook
          (lambda ()
            (when (eq major-mode 'pdf-view-mode) (pdf-tools-org-export-to-org))))

(use-package python
  :ensure nil
  :hook (python-mode . turn-on-prettify-symbols-mode))

(use-package yaml-mode
  :mode ("\\.yml\\'"))
