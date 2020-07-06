;;; bunny-editor.el --- BunnEmacs editor config
;;; Commentary:
;;; Code:

;; newline at end of file
(setq require-final-newline t)

;; store backup and autosave files in tmp
(setq backup-directory-alist
      '((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      '((".*" . ,temporary-file-directory)))

;; autosave undo-tree history
(setq undo-tree-history-directory-alist
      '((".*" . ,temporary-file-directory )))
(setq undo-tree-auto-save-history t)

;; revert buffers automatically when underlying files are externally changed
(global-auto-revert-mode t)

;; remember last location in file
(setq save-place-file (expand-file-name "saveplace" bunny-savefile-dir))
;; activate for all buffers
(save-place-mode 1)

;; savehist keeps some history
(require 'savehist)
(setq savehist-additional-variables
      ;; search entries
      '(search-ring regex-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep home clean
      savehist-file (expand-file-name "savehist" bunny-savefile-dir))
(savehist-mode +1)

;; save recent files
(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" bunny-savefile-dir)
      recentf-max-saved-items 5000
      recentf-max-menu-items 15
      ;; disable cleanup on restart
      recentf-auto-cleanup 'never)

(recentf-mode +1)

;; automagically save files when bugger is switched
(require 'super-save)
(super-save-mode +1)

(defadvice set-buffer-major-mode (after set-major-mode activate compile)
           "Set buffer major mode according to `auto-mode-alist`."
           (let* ((name (buffer-name buffer))
                  (mode (assoc-default name auto-mode-alist 'string-match)))
             (when (and mode (consp mode))
               (setq mode (car mode)))
             (with-current-buffer buffer (if mode (funcall mode)))))

;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" bunny-savefile-dir)
      bookmark-save-flag 1)

;; enable bunnEmacs keybindings
(bunny-mode t)

;; undo nicely
(global-undo-tree-mode)
(diminish 'undo-tree-mode)



(provide 'bunny-editor)
;;; bunny-editor.el ends here
