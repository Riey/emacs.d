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

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq auto-save-default nil)
(setq make-backup-files nil)
(add-to-list 'default-frame-alist '(font . "Hack-13"))
(set-face-attribute 'default t :font "Hack-13")
(set-fontset-font t 'hangul (font-spec :name "D2Coding-13"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq inhibit-startup-screen t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package dracula-theme
  :config
  (load-theme 'dracula t))

(use-package rainbow-identifiers
  :config
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))

;; (use-package color-identifiers-mode
;;   :config
;;   (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package magit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding  nil)
  :config
  (evil-mode 1))

(use-package powerline-evil
  :config
  (powerline-evil-vim-color-theme))

(defun my-cargo-process-test()
  "Run cargo test"
  (interactive)
  (cargo-process--start "Test" "test --all"))

(defun my-open-dot-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun my-load-dot-file()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(use-package evil-leader
 :config
 (evil-leader/set-leader "<SPC>")
 (evil-leader/set-key
   "f e"   'my-open-dot-file
   "f r"   'my-load-dot-file
   "g"     'magit
   "t"     'treemacs
   "r"     'recentf-open-files
   "e"     'find-file
   "<tab>" 'mode-line-other-buffer)
 (evil-leader/set-key-for-mode
   'lsp-mode
   "l g g" 'lsp-goto-type-definition
   "l g r" 'lsp-find-references
   "l r"   'lsp-rename
   "l b r" 'lsp-restart-workspace
   "l h"   'lsp-hover
   "l a"   'lsp-auto-execute-action
   "l f"   'lsp-format-buffer
   "l l"   'lsp-lens-mode)
 (evil-leader/set-key-for-mode
   'rust-mode
   "c c"   'cargo-process-check
   "c f"   'cargo-process-fmt
   "c b"   'cargo-process-build
   "c t"   'my-cargo-process-test)
 (global-evil-leader-mode))

(use-package evil-magit)
(use-package evil-escape
  :config
  (setq evil-escape-key-sequence "jk")
  (evil-escape-mode))

(use-package lsp-mode
  :config
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-eldoc-render-all nil))

(use-package which-key
  :config
  (which-key-setup-side-window-right)
  (which-key-setup-minibuffer)
  (which-key-mode))

(use-package yasnippet)

(use-package lsp-ui
  :after lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (define-key company-mode-map (kbd "C-SPC") 'company-complete-common)
  (define-key company-mode-map (kbd "C-l")   'company-complete-selection)
  (define-key company-mode-map (kbd "C-h")   'company-abort)
  (define-key company-mode-map (kbd "C-j")   'company-select-next)
  (define-key company-mode-map (kbd "C-k")   'company-select-previous)
  (define-key company-mode-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (setq company-idle-delay 0.1)
  (add-hook 'prog-mode-hook 'global-company-mode))

(use-package company-lsp
  :after company
  :config
  (push 'company-lsp company-backends))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package hl-todo
  :config
  (add-hook 'prog-mode-hook #'hl-todo-mode)
  (define-key hl-todo-mode-map (kbd "C-t p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-t n") 'hl-todo-next))

(use-package popwin
  :config
  (popwin-mode 1))

(use-package treemacs)
(use-package treemacs-evil)
(use-package treemacs-projectile)
(use-package treemacs-magit)
(use-package treemacs-icons-dired)

;; Emacs Lisp
(use-package company
  :config
  (push 'company-elisp company-backends))

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
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-analyzer-inlay-hints t)
  :config
  (add-hook 'rust-mode-hook #'lsp))
(use-package flycheck-rust
  :config
  (add-hook 'rust-mode-hook 'flycheck-mode))
(use-package cargo
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))
  
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-setup-minibuffer t)
 '(lsp-rust-analyzer-inlay-hints t t)
 '(lsp-rust-server (quote rust-analyzer))
 '(package-selected-packages
   (quote
    (evil-escape evil-magit rainbow-identifiers yasnippet company-anaconda avy-flycheck all-the-icons company-glsl glsl-mode flycheck-rust visual-regexp-steroids hl-todo rainbow-delimiters restart-emacs cargo use-package company-lsp company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))

(provide 'init)
;;; init.el ends here
