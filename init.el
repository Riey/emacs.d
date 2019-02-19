(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-theme 'dracula t)

(require 'helm)
(helm-mode 1)

(require 'evil)
(evil-mode 1)

(require 'powerline)
(powerline-center-evil-theme)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(require 'company-lsp)
(push 'company-lsp company-backends)

;; Haskell
(require 'lsp)
(require 'lsp-haskell)
(lsp-haskell-set-hlint-on)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-mode-hook 'flycheck-mode)

(set-frame-font "Hack 12" nil t)
(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-haskell yaml-mode helm company-lsp company evil dracula-theme lsp-ui flycheck powerline projectile lsp-rust lsp-haskell lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
