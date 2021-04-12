(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-check-signature nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable JIT
(setq comp-deferred-compilation t)
(setq package-native-compile t)

;; Set Korean
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(global-set-key (kbd "<muhenkan>") 'toggle-input-method)

(setq gc-cons-threshold 10000000)
(setq read-process-output-max (* 1024 1024))
(setq display-line-numbers-type 'relative)
(setq warning-minimum-level :emergency)
(global-display-line-numbers-mode)
(electric-pair-mode)
(recentf-mode 1)
(setq comint-move-point-for-output t)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(add-to-list 'default-frame-alist '(font . "Hack-13"))
(set-face-attribute 'default t :font "Hack-13")
(set-fontset-font t 'hangul (font-spec :name "D2Coding-13"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq inhibit-startup-screen t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package dracula-theme
  :config
  (load-theme 'dracula t))

;; Disable for speed
;; (use-package rainbow-identifiers
;;   :hook (prog-mode . rainbow-identifiers-mode))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package vterm)

(use-package ivy
  :config
  (ivy-mode 1))

(use-package magit)

(use-package golden-ratio
  :config
  (setq golden-ratio-auto-scale t)
  (golden-ratio-mode t)
  (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(evil-window-left
                  evil-window-right
                  evil-window-up
                  evil-window-down
                  buf-move-left
                  buf-move-right
                  buf-move-up
                  buf-move-down
                  window-number-select
                  select-window
                  select-window-1
                  select-window-2
                  select-window-3
                  select-window-4
                  select-window-5
                  select-window-6
                  select-window-7
                  select-window-8
                  select-window-9))))
(use-package evil
   :custom
   (evil-want-integration t)
   (evil-want-minibuffer t)
   (evil-want-keybinding  nil)
   :config
   (evil-mode 1))
(use-package undo-tree
  :config
  (global-undo-tree-mode))
(use-package undo-fu
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package powerline-evil
  :config
  (powerline-evil-vim-color-theme))

(use-package evil-magit
  :after evil)
(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

(defun my-cargo-process-run-release()
  "Run cargo run --relase"
  (interactive)
  (cargo-process--start "Run" "run --release"))

(defun my-cargo-process-test()
  "Run cargo test"
  (interactive)
  (cargo-process--start "Test" "test --all"))

(defun my-open-dot-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun my-open-repos()
  (interactive)
  (dired "~/repos"))

(defun my-load-dot-file()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(use-package evil-leader
  :after evil
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "b d"   'kill-buffer
    "w d"   'quit-window
    "f e"   'find-file
    "f d"   'my-open-dot-file
    "f w"   'my-open-repos
    "f r"   'my-load-dot-file
    "s"     'vterm
    "g"     'magit
    "r"     'recentf-open-files
    "<tab>" 'mode-line-other-buffer

    "t"     'treemacs

    "p b"   'projectile-compile-project
    "p r"   'projectile-ripgrep
    "p p"   'projectile-run-project
    "p f"   'projectile-find-file
    "p s"   'projectile-run-vterm

    "c n"   'cargo-process-new

    "h n"   'hl-todo-next
    "h p"   'hl-todo-previous

    "l g g" 'lsp-find-definition
    "l g r" 'lsp-find-references
    "l r"   'lsp-rename
    "l b r" 'lsp-workspace-restart
    "l h"   'lsp-hover
    "l a"   'lsp-execute-code-action
    "l f"   'lsp-format-buffer
    "l l"   'lsp-lens-mode)
  (evil-leader/set-key-for-mode
    'rust-mode
    "c a"   'cargo-process-add
    "c m"   'cargo-process-rm
    "c r d" 'cargo-process-run
    "c r r" 'my-cargo-process-run-release
    "c c"   'cargo-process-check
    "c f"   'cargo-process-fmt
    "c b"   'cargo-process-build
    "c t t" 'cargo-process-test
    "c t a" 'my-cargo-process-test)
  (global-evil-leader-mode))

(use-package lsp-mode
  :config
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-eldoc-render-all t)
  (setq lsp-auto-execute-action t)
  (setq lsp-diagnostic-package :flycheck)
  (setq lsp-enable-completion-at-point t)
  (setq lsp-enable-imenu t)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-semantic-highlighting t)
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-enable-text-document-color t)
  (setq lsp-enable-xref t)
  (setq lsp-prefer-capf t))

(use-package which-key
  :config
  (which-key-setup-side-window-right)
  (which-key-setup-minibuffer)
  (which-key-mode))

(use-package yasnippet
  :config
  (add-hook 'lsp-mode-hook 'yas-minor-mode-on))

(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-peek-always-show t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-symbol t)
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (push 'company-capf company-backends)
  (define-key company-mode-map (kbd "C-SPC") 'company-complete-common)
  (define-key company-active-map (kbd "C-l")   'company-complete-selection)
  (define-key company-active-map (kbd "<return>")   'company-complete-selection)
  (define-key company-active-map (kbd "C-h")   'company-abort)
  (define-key company-active-map (kbd "C-j")   'company-select-next)
  (define-key company-active-map (kbd "C-k")   'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0)
  (add-hook 'prog-mode-hook 'global-company-mode))

(use-package company-shell
  :after company
  :config
  (add-to-list 'company-backends '(company-shell company-shell-env company-fish-shell)))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))

(use-package popwin
  :config
  (popwin-mode 1))

(use-package all-the-icons)

(use-package projectile)

(use-package treemacs
  :config
  (progn
    (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0)
          treemacs-project-follow-cleanup t
          treemacs-workspace-switch-cleanup t)
    (treemacs-follow-mode t)
    (treemacs-fringe-indicator-mode t)
    (treemacs-git-mode 'deferred)))
(use-package treemacs-evil
  :after treemacs evil)
(use-package treemacs-projectile
  :after treemacs projectile)
(use-package treemacs-magit
  :after treemacs magit)
(use-package treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

;; Emacs Lisp
(use-package company
  :config
  (push 'company-elisp company-backends))

(use-package typescript-mode)

;; GLSL
(use-package glsl-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode)))

(use-package company-glsl
  :after company
  :config
  (add-to-list 'company-backends 'company-glsl))

;; Rust
(use-package lsp-mode
  :hook
  (rust-mode . lsp)
  :custom
  (lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-proc-macro-enable t)
  (lsp-rust-analyzer-server-display-inlay-hints t))
(use-package dap-mode
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb))
(use-package flycheck-rust
  :hook
  (rust-mode . flycheck-mode))
(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))
(use-package toml-mode)
  
;; Haskell
(use-package lsp-haskell
  :config
  (lsp-haskell-set-hlint-on)
  (use-package lsp-mode
    :config
    (add-hook 'haskell-mode-hook #'lsp))
  (use-package flycheck
    :config
    (add-hook 'haskell-mode-hook 'flycheck-mode)))

;; LaTeX
(use-package auctex)
(use-package pdf-tool)

;; yaml
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; pinentry
(use-package pinentry
  :config
  (setq epa-pinentry-mode 'loopback)
  (pinentry-start))

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

;; direnv
(use-package direnv
  :config
  (direnv-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-input-method "korean-hangul")
 '(package-selected-packages
   '(direnv pdf-tool undo-tree dap-python dap-lldb dap-mode yaml-mode frame-local all-the-icons-ivy typescript-mode ripgrep evil-escape evil-magit rainbow-identifiers yasnippet company-anaconda avy-flycheck all-the-icons company-glsl glsl-mode flycheck-rust visual-regexp-steroids hl-todo rainbow-delimiters restart-emacs cargo use-package company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))

(provide 'init)
;;; init.el ends here
