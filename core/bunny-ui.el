;;; bunny-ui.el --- UI Settings
;;; Commentary:
;;; Code:

;; default theme
(load-theme 'doom-nord t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; GUI
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

;; Font
(add-to-list 'initial-frame-alist '(font . "Fira-Code-13"))
(add-to-list 'default-frame-alist '(font . "Fira-Code-13"))
(set-fontset-font t 'symbol (font-spec :family "Apple Symbols") nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji" nil 'prepend)
;; Fringe

;; Scroll-bars

;; 



(provide 'bunny-ui)
;;; bunny-ui.el ends here.
