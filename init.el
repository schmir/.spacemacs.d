;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun black-buffer ()
  (interactive)
  (save-excursion
    (save-buffer)
    (shell-command (format "black %s" (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t)))

(defun schmir-disable-git-rebase-mode ()
  (setq auto-mode-alist
        (delete (rassq 'git-rebase-mode auto-mode-alist)
                auto-mode-alist)))

(eval-after-load "magit-autoloads"
  '(schmir-disable-git-rebase-mode))

(eval-after-load "git-rebase"
  '(schmir-disable-git-rebase-mode))

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs-base
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configurat)ion-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ansible
     elixir
     typescript
     haskell
     themes-megapack
     docker
     rust
     nginx
     yaml
     fsharp
     asciidoc
     html
     csv
     javascript
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (spacemacs-editing :packages aggressive-indent eval-sexp-fu expand-region hungry-delete undo-tree ws-butler smartparens spacemacs-whitespace-cleanup)
     spacemacs-language
     spacemacs-ui-visual
     spacemacs-editing-visual
     helm
     deft
     (org :packages
          company
          htmlize
          (ob :location elpa)
          (org :location elpa)
          (org-agenda :location elpa))
     (clojure :packages
              cider
              clojure-mode
              company
              eldoc
              subword)
     (git :packages evil-magit gitconfig-mode gitignore-mode magit)
     (auto-completion company company-quickhelp company-statistics fuzzy helm-company hippie-exp)
     auto-completion
     better-defaults
     emacs-lisp
     python
     ;; git
     markdown
     java
     sql
     shell
     windows-scripts
     lua
     nixos
     schmir
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(bbdb ag flymd)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(spaceline)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(leuven
                         white-sand
                         heroku
                         spacemacs-light
                         spacemacs-dark
                         light-blue)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode t
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))


(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; We need the following to make projectile work (i.e. not hang) on windows
  ;; See https://github.com/bbatsov/projectile/issues/790
  (let ((git-usr-bin "c:/Program Files/Git/usr/bin"))
    (when (and(eq system-type 'windows-nt)
              (file-exists-p git-usr-bin))
      (message "Adapting PATH and exec-path. %s" 5)
      (setenv "PATH" (concat (getenv "PATH") ";" git-usr-bin))
      (add-to-list 'exec-path git-usr-bin 't)))
  (eval-after-load "projectile"
    '(progn
       (add-to-list 'projectile-globally-ignored-directories ".mypy_cache")
       (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))
  ;; missing helm-bookmark-map, see
  ;; https://github.com/syl20bnr/spacemacs/issues/9549
  (defun dotspacemacs/user-init ()
    (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer--elpa-archives)
    (push '(helm . "melpa-stable") package-pinned-packages))

  ;; We need the following to be able to load this init file in a non-windowing
  ;; system since tool-bar-mode is customized with custom-set-variables at the
  ;; end of this file.
  (when (not (fboundp 'tool-bar-mode))
    (define-minor-mode tool-bar-mode
      ""
      :init-value t
      :global t
      :variable tool-bar-mode
      nil))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; Mitigate Bug#28350 (security) in Emacs 25.2 and earlier.
  ;; see http://seclists.org/oss-sec/2017/q3/422
  (eval-after-load "enriched"
    '(defun enriched-decode-display-prop (start end &optional param)
       (list start end)))

  (require 'helm-bookmark) ;; see above, missing helm-bookmark-map
  (setq helm-ag-insert-at-point 'symbol)


  (defalias 'br 'boxquote-region)
  (defalias 'cc 'cider-connect)
  (defalias 'sbke 'save-buffers-kill-emacs)
  (defalias 'g 'gnus)
  (defalias 'ee 'eval-expression)
  (defalias 'rb 'revert-buffer)

  (setq eclim-executable (expand-file-name "~/opt/eclipse/eclim"))
  (defun my-java-setup ()
    (setq show-trailing-whitespace nil)
    ;; https://stackoverflow.com/questions/6952369/java-mode-argument-indenting-in-emacs
    (c-set-offset 'arglist-intro '+))
  (add-hook 'java-mode-hook 'my-java-setup)


  (defun my-solidity-setup ()
    ;; https://stackoverflow.com/questions/6952369/java-mode-argument-indenting-in-emacs
    (c-set-offset 'arglist-intro '+)
    (setq c-basic-offset 4)
    (setq tab-width 8))
  (add-hook 'solidity-mode-hook 'my-solidity-setup)

  (setq recentf-auto-cleanup 60)

  (setq scroll-margin 2
        scroll-step 0
        scroll-conservatively 10000
        scroll-preserve-screen-position 1)

  (setq helm-buffer-max-length nil) ;; show complete buffer name in helm-buffer

  (setq create-lockfiles nil
        vc-follow-symlinks t				;; follow symlinks and don't ask
        vc-handled-backends nil)

  ;; when on a tab, make the cursor the tab length
  (setq-default x-stretch-cursor t)

  (windmove-default-keybindings)

  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
  (global-set-key [f12] 'menu-bar-mode) ;; gimme a quick way to toggle the menu-bar
  (global-set-key [f5] 'spacemacs/helm-project-smart-do-search)
  (global-set-key (kbd "C-x k") 'kill-this-buffer)
  (global-set-key (kbd "C-t") 'spacemacs/shell-pop-eshell)
  (global-set-key [C-tab] 'dabbrev-expand)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (setq send-mail-function 'message-send-mail-with-sendmail
        message-send-mail-function 'message-send-mail-with-sendmail

        ;; we substitute sendmail with msmtp
        sendmail-program "/usr/bin/msmtp"
        mail-specify-envelope-from t
        mail-envelope-from 'header
        message-sendmail-envelope-from 'header

        gnus-init-file (concat user-home-directory ".gnus-init.el"))

  (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook 'aggressive-indent-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
  (setq cider-show-eval-spinner nil
        cider-pprint-fn 'puget
        cider-repl-use-pretty-printing t)

  (define-key smartparens-mode-map (kbd "<M-right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "<M-left>") 'sp-forward-barf-sexp)
  (define-key smartparens-mode-map (kbd "<C-S-right>") 'sp-forward-sexp)
  (define-key smartparens-mode-map (kbd "<C-S-left>") 'sp-backward-sexp)
  (define-key smartparens-mode-map (kbd "C-S-k") 'sp-kill-sexp)
  (define-key smartparens-mode-map (kbd "<M-up>") 'sp-splice-sexp)
  (define-key evil-emacs-state-map (kbd "C-z") nil)
  (global-set-key (kbd "C-z") 'undo-tree-undo)
  (global-set-key (kbd "C-S-z") 'undo-tree-redo)

  ;; --- python
  (add-hook 'python-mode-hook 'flycheck-mode)
  (add-hook 'python-mode-hook
            (lambda()
              (setq flycheck-python-flake8-executable "python3"
                    flycheck-python-pycompile-executable "python3"
                    flycheck-python-pylint-executable "python3"
                    flycheck-python-mypy-executable "python3")

              (define-key python-mode-map (kbd "C-c b") 'black-buffer)))

  ;; automatically chmod +x when the file has shebang "#!"
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(blink-cursor-mode nil)
 '(browse-url-browser-function (quote browse-url-firefox))
 '(column-number-mode t)
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (jinja2-mode company-ansible ansible-doc ansible richie-theme transient google-translate define-word ob-elixir flycheck-mix flycheck-credo alchemist elixir-mode tide typescript-mode intero hlint-refactor hindent helm-hoogle haskell-snippets company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode zenburn-theme zen-and-art-theme white-sand-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme rebecca-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme exotica-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme sesman dockerfile-mode docker tablist docker-tramp flymd toml-mode racer cargo rust-mode nginx-mode yaml-mode ghub let-alist solidity-mode fsharp-mode flycheck company-quickhelp pos-tip adoc-mode markup-faces web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode company-web web-completion-data boxquote web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode csv-mode nix-mode helm-nixos-options company-nixos-options nixos-options lua-mode powershell framemove deft xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help highlight-symbol misc-cmds sequential-command sql-indent company-emacs-eclim eclim yapfify pyvenv pytest pyenv-mode py-isort pip-requirements org-projectile org-present org-plus-contrib org-pomodoro alert log4e gntp org-download mmm-mode markdown-toc markdown-mode live-py-mode hy-mode htmlize helm-pydoc gnuplot gh-md cython-mode company-anaconda anaconda-mode pythonic f volatile-highlights rainbow-delimiters indent-guide highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt column-enforce-mode auto-highlight-symbol adaptive-wrap spaceline powerline popwin neotree hl-todo golden-ratio fill-column-indicator fancy-battery ws-butler hungry-delete expand-region eval-sexp-fu highlight aggressive-indent ag s smartparens unfill mwim helm-company helm-c-yasnippet gitignore-mode gitconfig-mode fuzzy evil-magit magit magit-popup git-commit with-editor company-statistics company auto-yasnippet yasnippet ac-ispell auto-complete cider spinner queue clojure-mode beacon seq bbdb which-key use-package pcre2el macrostep hydra help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx flx helm-descbinds helm-ag exec-path-from-shell evil-visualstar evil-escape evil goto-chg undo-tree elisp-slime-nav diminish bind-map bind-key auto-compile packed dash ace-window ace-jump-helm-line helm avy helm-core popup async)))
 '(safe-local-variable-values
   (quote
    ((buffer-file-coding-system . latin-1-dos)
     (buffer-file-coding-system . cp1252-dos)
     (buffer-file-coding-system . utf-8-dos))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
