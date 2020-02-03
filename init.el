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

(use-package dracula-theme
  :config
  (load-theme 'dracula t))

(use-package color-identifiers-mode
  :config
  (add-hook 'after-init-hook 'global-color-identifiers-mode))

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

;;(use-package evil-leader
;; ;; :config
;; (global-evil-leader-mode)
;; (evil-leader/set-leader "<SPC>"))

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(use-package golden-ratio
  :config
  (golden-ratio-mode 1))

(use-package visual-regexp-steroids
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  (define-key esc-map (kbd "C-r") 'vr/isearch-backward)
  (define-key esc-map (kbd "C-s") 'vr/isearch-forward))

(use-package lsp-mode
  :config
  (with-eval-after-load 'lsp-mode
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)))

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
  (global-set-key (kbd "C-SPC") 'company-complete-common)
  (global-set-key (kbd "C-l")   'company-complete-selection)
  (global-set-key (kbd "<tab>") 'company-complete-common-or-cycle)
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

(use-package neotree
  :config
  (global-set-key [f2] 'neotree-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q")   'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "g")   'neotree-refresh)
  (evil-define-key 'normal neotree-mode-map (kbd "n")   'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p")   'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A")   'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H")   'neotree-hidden-file-toggle)
  (setq-default neo-persist-show t)
  (when neo-persist-show
    (add-hook 'popwin:before-popup-hook
              (lambda () (setq neo-persist-show nil)))
    (add-hook 'popwin:after-popup-hook
              (lambda () (setq neo-persist-show t))))
  (use-package all-the-icons
    )
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

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
  :config
  (add-hook 'rust-mode-hook #'lsp))
  ;;(use-package dash)
  ;;(use-package ht)
  ;;(load "~/.emacs.d/rust-analyzer")
  ;;(require 'rust-analyzer)
  ;;(setq lsp-rust-server 'rust-analyzer)
  ;;(setq lsp-rust-analyzer-inlay-hints t)
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
 '(package-selected-packages
   (quote
    (yasnippet company-anaconda avy-flycheck all-the-icons company-glsl glsl-mode flycheck-rust visual-regexp-steroids hl-todo rainbow-delimiters restart-emacs cargo use-package company-lsp company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))

(provide 'init)
;;; init.el ends here
