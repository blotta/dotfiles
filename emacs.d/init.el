(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; use-package FINE
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Gruvbox
(unless (package-installed-p 'gruvbox-theme)
  (package-refresh-contents)
  (package-install 'gruvbox-theme))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox-dark-medium)))
 '(custom-safe-themes
   (quote
	("54e08527b4f4b127ebf7359acbbbecfab55152da01716c4809682eb71937fd33" default)))
 '(package-selected-packages
   (quote
	(shell-pop company-go company go-mode ido-vertical-mode evil-tabs evil-commentary magit beacon linum-relative which-key smex org-bullets use-package gruvbox-theme evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
