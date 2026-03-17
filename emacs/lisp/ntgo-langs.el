;;; ntgo-langs.el --- LSP and language support -*- lexical-binding: t -*-

;;; Package updates

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

;;; LSP

(use-package eglot
  :ensure nil
  :hook (prog-mode . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c c a" . eglot-code-actions)
              ("C-c c o" . eglot-code-actions-organize-imports)
              ("C-c c r" . eglot-rename)
              ("C-c c f" . eglot-format)))

(use-package eldoc
  :ensure nil
  :init
  (global-eldoc-mode))

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

;;; Formatters

(use-package reformatter
  :ensure t)

;;; Languages

(use-package ess
  :ensure t)

(use-package haskell-mode
  :ensure t
  :config
  (reformatter-define fourmolu-format
    :program "fourmolu"
    :args `("--stdin-input-file" ,buffer-file-name))
  (add-hook 'haskell-mode-hook #'fourmolu-format-on-save-mode))

(use-package rust-mode
  :ensure t
  :defer t
  :init
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-hook 'rust-mode-hook #'prettify-symbols-mode)
  :config
  (setq rust-format-on-save t)
  :bind ("M-," . rust-compile))

(use-package flycheck-rust
  :ensure t
  :hook (flycheck-mode . flycheck-rust-setup))

(use-package go-ts-mode
  :ensure nil
  :mode "\\.go\\'"
  :init
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode))
  :config
  (with-eval-after-load 'eglot
    (setq-default eglot-workspace-configuration
                  '(:gopls (:hints (:assignVariableTypes t
                                    :compositeLiteralFields t
                                    :compositeLiteralTypes t
                                    :constantValues t
                                    :functionTypeParameters t
                                    :parameterNames t
                                    :rangeVariableTypes t))
                    :haskell (:maxCompletions 40
                              :checkProject t
                              :formattingProvider "none")))
    (add-hook 'go-ts-mode-hook #'eglot-inlay-hints-mode)))

(use-package gdscript-mode
  :ensure t
  :hook (gdscript-mode . eglot-ensure))

(provide 'ntgo-langs)
;;; ntgo-langs.el ends here
