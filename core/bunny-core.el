;;; bunny-core.el --- BunnEmacs Core Functionality
;;; Commentary:
;;; Code:
(require 'thingatpt)

;; buffer-mode
(defun bunny-buffer-mode (buffer-or-name)
"Get the `major-mode` of BUFFER-OR-NAME."
(with-current-buffer buffer-or-name
major-mode))


;; Recompile init
(defun bunny-recompile-init ()
(interactive)
(byte-recompile-directory bunny-dir 0))


(provide 'bunny-core)
;;; bunny-core.el ends here