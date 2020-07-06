;;; cobalt-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cobalt" "cobalt.el" (0 0 0 0))
;;; Generated autoloads from cobalt.el

(autoload 'cobalt-init "cobalt" "\
Create a new cobalt site at the given path indicated by ARGS.

\(fn ARGS)" t nil)

(autoload 'cobalt-change-current-site "cobalt" "\
Show a selection to switch current site.
Kills an exiting server process.  User should run ‘cobalt-serve’ again for the newly switch site.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cobalt" '("cobalt-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cobalt-autoloads.el ends here
