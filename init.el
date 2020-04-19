(load "~/.emacs.d/sanemacs.el" nil t)

;;; Your configuration goes below this line.
;;; use-package is already loaded and ready to go!
;;; use-package docs: https://github.com/jwiegley/use-package

;; Rust settings
(require 'rust-mode)
(with-eval-after-load 'rust-mode
;; Rust Formatter. Run rustfmt before saving rust buffers
(setq rust-format-on-save t))

;; Add keybindings for interacting with Cargo
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(require 'lsp-mode) ;; language server protocol
(with-eval-after-load 'lsp-mode
(add-hook 'rust-mode-hook #'lsp))
;; (add-hook 'rust-mode-hook #'flycheck-mode))

;; excessive UI feedback for light reading between coding
(require 'lsp-ui)
(with-eval-after-load 'lsp-ui
(add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; autocompletions for lsp (available with melpa enabled)
(require 'company-lsp)
(push 'company-lsp company-backends)

;; tell company to complete on tabs instead of sitting there like a moron
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)

(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
          (setq company-minimum-prefix-length 1))

(require 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

(require 'undo-tree)
(global-undo-tree-mode)

(setq cua-rectangle-mark-key (kbd "C-^"))
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(cua-mode t)

(require 'yasnippet)
(yas-global-mode 1)

(require 'which-key)
(which-key-mode)

(require 'desktop+)

;; companymode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)
;; company delay until suggestions are shown
(setq company-idle-delay 0.1)
;; weight by frequency
(setq company-transformers '(company-sort-by-occurrence))

;; Add yasnippet support for all company backends
(defvar company-mode/enable-yas t "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend)    (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
	    '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

(require 'helm)
(require 'helm-config)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-M-x-fuzzy-match                  t ; optional fuzzy matching for helm-M-x
      helm-echo-input-in-header-line        t
      )

;; (setq helm-autoresize-max-height 0)
;; (set q helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c h x") 'helm-register)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'linum-relative)
(setq linum-relative-backend 'display-line-numbers-mode)
;; (setq linum-relative-global-mode)
(global-display-line-numbers-mode)

(setq reftex-bibliography-commands '("addbibresource"))
(autoload 'helm-bibtex "helm-bibtex" "" t)
(setq bibtex-completion-format-citation-functions
      '((org-mode      . bibtex-completion-format-citation-org-link-to-PDF)
	(latex-mode    . bibtex-completion-format-citation-cite)
	(markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
	(default       . bibtex-completion-format-citation-default)))

(global-set-key (kbd "<apps>") 'helm-command-prefix)
(define-key helm-command-map "B" 'helm-bibtex)
(define-key helm-command-map "b" 'helm-bibtex-with-local-bibliography)
(define-key helm-command-map (kbd "<apps>") 'helm-resume)

(setq org-return-follows-link t)
(setq org-agenda-start-on-weekday 1)
(setq org-duration-format (quote h:mm))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d@!)" "CANCELED(c@!)")))

(add-to-list 'exec-path "C:/msys64/mingw64/bin/")
(setq ispell-program-name (locate-file "hunspell"
				       exec-path exec-suffixes 'file-executable-p))
(setq ispell-dictionary-alist '(
				("american"
				 "[[:alpha:]]"
				 "[^[:alpha:]]"
				 "[']"
				 t
				 ("-d" "en_US" "-p" "C:\\msys64\\mingw64\\share\\hunspell\\personal.en")
				 nil
				 iso-8859-1)
				))
;; (setq ispell-dictionary "american")

(global-set-key [f7] 'spell-checker)

(require 'ispell)
(require 'flyspell)
(defun spell-checker ()
  "spell checker (on/off) with selectable dictionary"
  (interactive)
  (if flyspell-mode
      (flyspell-mode-off)
    (progn
      (flyspell-mode)
      (ispell-change-dictionary
       (completing-read
        "Use new dictionary (RET for *default*): "
        (and (fboundp 'ispell-valid-dictionary-list)
         (mapcar 'list (ispell-valid-dictionary-list)))
        nil t))
      )))

(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; AucTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;; (add-hook 'LaTeX-mode-hook
;;           (lambda ()
;;             (add-to-list 'TeX-command-list
;;                          '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;;                            :help "Run latexmk on file"))))

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
	;; This would override `fill-column' if it's an integer.
	(emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

; keep a list of recently opened files                                                                      
 (recentf-mode 1)
 (setq-default recent-save-file "~/.emacs.d/recentf")  
