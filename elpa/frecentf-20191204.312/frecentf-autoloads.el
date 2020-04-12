;;; frecentf-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "frecentf" "frecentf.el" (0 0 0 0))
;;; Generated autoloads from frecentf.el

(autoload 'frecentf-pick-file "frecentf" "\
Pick a file and call ACTION on it.

When called interactively, call `find-file'

\(fn ACTION)" t nil)

(autoload 'frecentf-pick-dir "frecentf" "\
Pick a file and call ACTION on it.

When called interactively, call `dired'

\(fn ACTION)" t nil)

(defvar frecentf-mode nil "\
Non-nil if Frecentf mode is enabled.
See the `frecentf-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `frecentf-mode'.")

(custom-autoload 'frecentf-mode "frecentf" nil)

(autoload 'frecentf-mode "frecentf" "\
Toggle frecentf mode.

Mostly based off `recentf-mode'

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "frecentf" '("frecentf-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; frecentf-autoloads.el ends here
