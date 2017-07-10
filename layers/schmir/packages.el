;;; packages.el --- schmir layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Ralf Schmitt <ralf@systemexit.de>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `schmir-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `schmir/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `schmir/pre-init-PACKAGE' and/or
;;   `schmir/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst schmir-packages
  '(which-func (rosi :location local) framemove sequential-command misc-cmds highlight-symbol beacon boxquote)
  "The list of Lisp packages required by the schmir layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun schmir/init-boxquote ()
  (use-package boxquote))

(defun schmir/init-framemove ()
  (use-package framemove
    :init (setq framemove-hook-into-windmove t)))

(defun schmir/init-sequential-command ()
  (use-package sequential-command
    :config
    (progn
      (define-sequential-command schmir/home
        ;; back-to-indentation
        ;; beginning-of-line
        beginning-of-buffer
        seq-return)

      (define-sequential-command schmir/end
        ;; end-of-line
        end-of-buffer
        seq-return)
      (global-set-key [home] 'schmir/home)
      (global-set-key [end] 'schmir/end))))

(defun schmir/init-misc-cmds ()
  (use-package misc-cmds :ensure t
    :commands (mark-buffer-before-point mark-buffer-after-point)
    :init
    (progn
      (define-key ctl-x-map [home] #'mark-buffer-before-point)
      (define-key ctl-x-map [end]  #'mark-buffer-after-point))))

(defun schmir/init-highlight-symbol ()
  (use-package highlight-symbol :ensure t
    :commands highlight-symbol-mode
    :bind (([(control f1)]	. highlight-symbol-at-point)
           ([f1]			. highlight-symbol-next)
           ([(shift f1)]		. highlight-symbol-prev)
           ([(meta f1)]		. highlight-symbol-query-replace))
    :init
    (progn
      (defun turn-on-highlight-symbol-mode ()
        (interactive)
        (highlight-symbol-mode 1)))

    :config
    (setq highlight-symbol-idle-delay 0.3)))

(defun schmir/init-beacon ()
  (use-package beacon
    :ensure t
    :config (setq beacon-blink-duration 0.6
                  beacon-size 80)    
    :init (beacon-mode 1)))

(defun schmir/init-which-func ()
  (use-package which-func
    :init
    (which-func-mode 1)))

(defun schmir/init-rosi ()
  (use-package rosi
    :commands rosi-mode
    :mode ("\\.rsf\\|\\.rsi\\'" . rosi-mode)
    :init (modify-coding-system-alist 'file "\\(\\.rsf\\|\\.msg\\)$" 'cp437)
    :config
    (progn
      (defun schmir/setup-rosi ()
        (turn-on-highlight-symbol-mode)
        (abbrev-mode 0)
        (setq fill-column 140
              show-trailing-whitespace nil))
      (add-hook 'rosi-mode-hook 'schmir/setup-rosi))))

(with-eval-after-load 'clojure-mode
  (message "configuring clojure-mode")
  (define-clojure-indent
    (event-handler 'defun))

  (define-key clojure-mode-map (kbd "<f10>") #'cider-connect)
  
  ;; fix indentation of cond expressions
  ;; see https://github.com/clojure-emacs/clojure-mode/issues/337
  (defun schmir/indent-cond (indent-point state)
    (goto-char (elt state 1))
    (let ((pos -1)
          (base-col (current-column)))
      (forward-char 1)
      ;; `forward-sexp' will error if indent-point is after
      ;; the last sexp in the current sexp.
      (condition-case nil
          (while (and (<= (point) indent-point)
                      (not (eobp)))
            (clojure-forward-logical-sexp 1)
            (cl-incf pos))
        ;; If indent-point is _after_ the last sexp in the
        ;; current sexp, we detect that by catching the
        ;; `scan-error'. In that case, we should return the
        ;; indentation as if there were an extra sexp at point.
        (scan-error (cl-incf pos)))
      (+ base-col (if (evenp pos) 4 2))))
  (put-clojure-indent 'cond #'schmir/indent-cond))

(with-eval-after-load 'cider
  (defun schmir/cider-load-buffer-in-repl ()
    (interactive)
    (cider-load-buffer)
    (cider-repl-set-ns (cider-current-ns))
    (cider-switch-to-repl-buffer))

  (define-key cider-mode-map '[f10] #'schmir/cider-load-buffer-in-repl)

  (define-key cider-repl-mode-map '[f10] 'delete-window)
  (define-key cider-repl-mode-map (kbd "C-c C-w") 'cider-eval-last-sexp-and-replace)
  (define-key cider-stacktrace-mode-map '[f10] 'cider-popup-buffer-quit-function)
  (define-key cider-docview-mode-map '[f10] 'cider-popup-buffer-quit-function)
  (define-key cider-docview-mode-map (kbd "H-h") 'cider-popup-buffer-quit-function)
  (define-key cider-mode-map (kbd "H-a") 'helm-cider-apropos)
  (define-key cider-repl-mode-map (kbd "H-a") 'helm-cider-apropos)
  (define-key cider-mode-map (kbd "H-h") 'cider-doc)
  (define-key cider-repl-mode-map (kbd "H-h") 'cider-doc))

(with-eval-after-load 'recentf
  (recentf-cleanup))

(with-eval-after-load 'projectile
  (projectile-cleanup-known-projects))

;;; packages.el ends here
