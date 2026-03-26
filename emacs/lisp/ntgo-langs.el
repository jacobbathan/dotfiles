;;; ntgo-langs.el --- LSP and language support -*- lexical-binding: t -*-

;;; LSP

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-completion-provider :none)   ; hand completion to corfu
  :hook
  ((lsp-mode  . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
              ("C-c c a" . lsp-execute-code-action)
              ("C-c c o" . lsp-organize-imports)
              ("C-c c r" . lsp-rename)
              ("C-c c f" . lsp-format-buffer))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-peek-enable t))

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-ui-mode 1)
  ;; codelldb: single download covers C, C++, and Rust
  (require 'dap-codelldb)
  (dap-codelldb-setup))

(use-package eldoc
  :ensure nil
n  :init
  (global-eldoc-mode))

;;; Formatters

(use-package reformatter
  :ensure t)

;;; Polyglot editing

(use-package polymode
  :ensure t)

(use-package poly-R
  :ensure t
  :mode (("\\.Rmd\\'" . poly-markdown+r-mode)
         ("\\.qmd\\'" . poly-markdown-mode)))

;;; Languages

;; --- R ---

(use-package ess
  :ensure t)

;; --- Haskell ---

(use-package haskell-mode
  :ensure t
  :config
  (reformatter-define fourmolu-format
    :program "fourmolu"
    :args `("--stdin-input-file" ,buffer-file-name))
  (add-hook 'haskell-mode-hook #'fourmolu-format-on-save-mode))

(use-package lsp-haskell
  :ensure t
  :hook (haskell-mode . lsp-deferred)
  :config
  (setq lsp-haskell-formatting-provider "none"))

;; --- Rust (rustic replaces rust-mode and flycheck-rust) ---

(use-package rustic
  :ensure t
  :after lsp-mode
  :custom
  (rustic-lsp-client 'lsp-mode)
  (rustic-format-on-save t)
  :config
  ;; codelldb already set up in dap-mode block above; require the module here
  ;; so dap templates for Rust are registered
  (require 'dap-codelldb)
  :bind (:map rustic-mode-map
              ("M-," . rustic-compile)))

;; --- Go ---

(use-package go-ts-mode
  :ensure nil
  :mode "\\.go\\'"
  :init
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode))
  :hook
  ((go-ts-mode . lsp-deferred)
   (go-ts-mode . lsp-inlay-hints-mode)
   (go-ts-mode . goimports-format-on-save-mode))
  :config
  (reformatter-define goimports-format
    :program "goimports")
  (lsp-register-custom-settings
   '(("gopls.hints.assignVariableTypes"    t t)
     ("gopls.hints.compositeLiteralFields" t t)
     ("gopls.hints.compositeLiteralTypes"  t t)
     ("gopls.hints.constantValues"         t t)
     ("gopls.hints.functionTypeParameters" t t)
     ("gopls.hints.parameterNames"         t t)
     ("gopls.hints.rangeVariableTypes"     t t)))
  (require 'dap-go)
  (dap-go-setup))

;; --- GDScript ---

(use-package gdscript-mode
  :ensure t)

;; --- C / C++ ---

(use-package c-ts-mode
  :ensure nil
  :mode (("\\.c\\'"   . c-ts-mode)
         ("\\.h\\'"   . c-ts-mode)
         ("\\.cpp\\'" . c++-ts-mode)
         ("\\.hpp\\'" . c++-ts-mode))
  :hook ((c-ts-mode . lsp-deferred)
	 (c++-ts-mode . lsp-deferred))
  :config
  ;; codelldb handles C/C++ debugging; setup is done in dap-mode block
  (require 'dap-codelldb))

(use-package cmake-mode
  :ensure t)

;; --- Python (basedpyright + debugpy) ---

(use-package lsp-basedpyright
  :ensure t
  :after lsp-mode
  :hook (python-ts-mode . lsp-deferred))

(use-package dap-python
  :ensure nil
  :after dap-mode
  :config
  (setq dap-python-debugger 'debugpy))

(use-package pyvenv
  :ensure t
  :hook (python-ts-mode . pyvenv-mode))

;; --- Perl ---

(use-package cperl-mode
  :ensure nil
  :mode ("\\.pl\\'" "\\.pm\\'" "\\.t\\'"))

;; --- OCaml (ocamlearlybird via dap-ocaml) ---

;; ASSUMPTION: dap-ocaml.el is present in the installed version of dap-mode.
;; It was added in dap-mode 0.8+.  If `require' fails, update dap-mode.
;; Install the adapter itself with: opam install earlybird
(use-package tuareg
  :ensure t
  :hook (tuareg-mode . lsp-deferred)
  :config
  (require 'dap-ocaml))

;; --- Typescript/Javascript ---
(use-package typescript-ts-mode
  :ensure nil
  :mode (("\\.ts\\'" . typescript-ts-mode)
	 ("\\.tsx\\'" . tsx-ts-mode)
	 ("\\.js\\'" . js-ts-mode)
	 ("\\.jsx\\'" . js-ts-mode))
  :hook
   ((typescript-ts-mode . lsp-deferred)
   (tsx-ts-mode . lsp-deferred)
   (js-ts-mode . lsp-deferred))
  :config
    (require 'dap-node))

(reformatter-define prettier-format
  :program "prettier"
  :args `("--stdin-filepath" ,buffer-file-name))

;; --- C# ---
(use-package csharp-ts-mode
  :ensure nil
  :mode "\\.cs\\'"
  :config
  (require 'dap-netcore)
  :hook
  ((csharp-ts-mode . lsp-deferred)))


(provide 'ntgo-langs)
;;; ntgo-langs.el ends here
