;;; bunny-global-keybindings.el --- Global keybindings
;;; Commentary:
;;; Code:

;; C-x o moves to next window
(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
                                (other-window -1)))

;; kill lines backwards
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))




(provide 'bunny-global-keybindings)
;;; bunny-global-keybindings.el ends here
