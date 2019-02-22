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

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package helm
  :ensure t
  :config
  (helm-mode 1))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package powerline
  :ensure t
  :config
  (powerline-center-evil-theme))

(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (global-set-key (kbd "C-c SPC") 'company-complete-common))

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package hl-todo
  :ensure t
  :config
  (hl-todo-mode)
  (define-key hl-todo-mode-map (kbd "C-t p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-t n") 'hl-todo-next))

;; Emacs Lisp
(use-package company
  :ensure t
  :config
  (push 'company-elisp company-backends)
  (add-hook 'emacs-lisp-mode-hook 'company-mode))

;; Rust
(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'lsp)
  (use-package flycheck-rust
    :config
    (add-hook 'rust-mode-hook 'flycheck-mode)))

(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))
  
;; Haskell
(use-package lsp-haskell
  :ensure t
  :config
  (lsp-haskell-set-hlint-on)
  (use-package lsp-mode
    :ensure t
    :config
    (add-hook 'haskell-mode-hook #'lsp))
  (use-package flycheck
    :config
    (add-hook 'haskell-mode-hook 'flycheck-mode)))

(global-linum-mode)
(setq auto-save-default nil)
(set-frame-font "Hack 12" nil t)
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (hl-todo rainbow-delimiters restart-emacs cargo use-package helm company-lsp company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))
