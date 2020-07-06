;;; scratch-pop-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "scratch-pop" "scratch-pop.el" (0 0 0 0))
;;; Generated autoloads from scratch-pop.el

(autoload 'scratch-pop "scratch-pop" "\
Popup a scratch buffer. If `*scratch*' is already displayed,
create new scratch buffers `*scratch2*', `*scratch3*', ... .

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "scratch-pop" '("scratch-pop-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; scratch-pop-autoloads.el ends here
