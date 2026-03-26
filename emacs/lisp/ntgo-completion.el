;;; ntgo-completion.el --- Completion stack -*- lexical-binding: t -*-

;;; Minibuffer UI

(use-package vertico
  :ensure t
  :demand t
  :init
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("DEL" . vertico-directory-delete-char)))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; Enhanced commands

(use-package consult
  :ensure t
  :custom
  (consult-preview-key "M-.")
  :bind
  (("C-x b" . consult-buffer)
   ("M-l"   . consult-git-grep)
   ("M-y"   . consult-yank-pop)
   ("M-s"   . consult-line)))

(use-package embark
  :ensure t
  :bind
  (("C-."   . embark-act)
   ("C-;"   . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;; In-buffer completion

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map
              ("<tab>" . corfu-complete)
              ("SPC"   . corfu-insert-separator))
  :custom
  (corfu-auto t)
  (tab-always-indent 'complete)
  (corfu-preview-current nil)
  (corfu-min-width 20)
  (corfu-popupinfo-delay '(1.25 . 0.5))
  :config
  (corfu-popupinfo-mode 1)
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package corfu-terminal
  :ensure t
  :unless (display-graphic-p)
  :config
  (corfu-terminal-mode +1))

(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(provide 'ntgo-completion)
;;; ntgo-completion.el ends here

