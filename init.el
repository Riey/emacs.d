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

(global-linum-mode)
(setq auto-save-default nil)
(setq make-backup-files nil)
(add-to-list 'default-frame-alist '(font . "Hack-11"))
(set-face-attribute 'default t :font "Hack-11")
(set-fontset-font t 'hangul (font-spec :name "D2Coding-11"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq inhibit-startup-screen t)

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
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :init
  (evil-collection-init))

(use-package powerline
  :ensure t
  :config
  (powerline-center-evil-theme))

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1))

(use-package visual-regexp-steroids
  :ensure t
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  (define-key esc-map (kbd "C-r") 'vr/isearch-backward)
  (define-key esc-map (kbd "C-s") 'vr/isearch-forward))

(use-package lsp-mode
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package lsp-ui
  :after lsp-mode
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (global-set-key (kbd "C-SPC") 'company-complete-common)
  (setq company-idle-delay 0.1))

(use-package company-lsp
  :after company
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
  (add-hook 'prog-mode-hook #'hl-todo-mode)
  (define-key hl-todo-mode-map (kbd "C-t p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-t n") 'hl-todo-next))

(use-package neotree
  :ensure t
  :config
  (global-set-key [f2] 'neotree-toggle)
  (use-package all-the-icons
    :ensure t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Emacs Lisp
(use-package company
  :ensure t
  :config
  (push 'company-elisp company-backends)
  (add-hook 'emacs-lisp-mode-hook 'company-mode))

;; GLSL
(use-package glsl-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode)))

(use-package company-glsl
  :after company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-glsl)
  (add-hook 'glsl-mode-hook 'company-mode))

;; Rust
(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'lsp))
(use-package flycheck-rust
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'flycheck-mode))
(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(when-let ((use-rust-analzer t))
  (use-package dash
    :ensure t)
  (use-package ht
    :ensure t)
  (load "~/.emacs.d/ra-emacs-lsp")
  (require 'ra-emacs-lsp))

;; F#
(use-package fsharp-mode
  :ensure t
  :config
  (setq inferior-fsharp-program "/opt/dotnet_core/sdk/2.2.103/FSharp/fsi.exe")
  (setq fsharp-compiler "/opt/dotnet_core/sdk/2.2.103/FSharp/fsc.exe")
  (use-package highlight-indentation
    :ensure t
    :config
    (add-hook 'fsharp-mode-hook 'highlight-indentation-mode)))
  
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet company-anaconda avy-flycheck all-the-icons company-glsl glsl-mode flycheck-rust visual-regexp-steroids hl-todo rainbow-delimiters restart-emacs cargo use-package helm company-lsp company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))

(provide 'init)
;;; init.el ends here
