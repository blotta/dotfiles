(package-initialize)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (jedi gruvbox-theme tabbar-ruler tabbar markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Random els load-path
(add-to-list 'load-path "~/.emacs.d/random-ass-els")

(progn
  ;;turn on highlight matching brackets when cursoe is on one
  (show-paren-mode 1)

  ;;highlight brackets
  (setq show-paren-style 'parenthesis)
  )

;;set a default font
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono-10"))

;; Theme
(load-theme 'gruvbox t)


;; stop creating automatic backup~ files
(setq make-backup-files nil)
;; disable #auto-save# backup files
(setq auto-save-default nil)
;; Automatically refresh files modified elsewhere
(global-auto-revert-mode 1)

;; Auto-complete-mode
(ac-config-default)

;; Python
;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Golang
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
