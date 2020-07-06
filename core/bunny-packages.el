;;; bunny-packages.el --- Package List
;;; Commentary:
;;; Code:

(require 'package)

;; set package-user-dir relative to BunnEmacs install path
(setq package-user-dir (expand-file-name "elpa" bunny-dir))
(package-initialize)

(defvar bunny-packages
  '(browse-kill-ring
    diminish
    easy-kill
    gist
    imenu-anywhere
    super-save
    undo-tree
    use-package)
  "List of packages needed at launch.")

(defun bunny-packages-installed-p ()
  "check if all base packages are installed."
  (every #'package-installed-p bunny-packages))

(defun bunny-require-package (package)
  "Install PACKAGE unless its already installed."
  (unless (memq package bunny-packages)
    (add-to-list 'bunny-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun bunny-require-packages (packages)
  "Ensure PACKAGES are installed."
  (mapc #'bunny-require-package packages))

(defun bunny-install-packages ()
  "Install all required packages."
  (unless (bunny-packages-installed-p)
    (message "%s" "BunnEmacs is refreshing package database...")
    (package-refresh-contents)
    (message "%s" " done!")
    ;; install missing
    (bunny-require-packages bunny-packages)))

;;; run install
(bunny-install-packages)




(provide 'bunny-packages)
;;; bunny-packages.el ends here
