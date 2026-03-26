;;; ntgo-ui.el --- Visual appearance and UI packages -*- lexical-binding: t -*-

;;; Font and spacing

(set-face-attribute 'default nil
                    :font "Iosevka Nerd Font"
                    :height 160
                    :weight 'medium)
(setq-default line-spacing 0.12)

;;; Theme

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;;; Icons

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;; Which-key

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(provide 'ntgo-ui)
;;; ntgo-ui.el ends here
