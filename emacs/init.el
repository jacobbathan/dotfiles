;;; init.el --- Emacs configuration entry point -*- lexical-binding: t -*-

;;; Package management

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq package-archives '(("melpa"  . "https://melpa.org/packages/")
                         ("org"    . "https://orgmode.org/elpa/")
                         ("elpa"   . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Suppress noisy install buffers
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;; Load modules

(add-to-list 'load-path (locate-user-emacs-file "lisp"))

(require 'ntgo-core)
(require 'ntgo-ui)
(require 'ntgo-completion)
(require 'ntgo-langs)
(require 'ntgo-org)
(require 'ntgo-denote)
(require 'ntgo-tools)

;;; Custom variables (Emacs-managed, do not edit directly)

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error)

;;; init.el ends here
