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