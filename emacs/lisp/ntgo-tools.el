;;; ntgo-tools.el --- Editing tools and utilities -*- lexical-binding: t -*-

;;; Text formats

(use-package markdown-mode
  :ensure t)

;;; Help and documentation

(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-h d" . helpful-at-point)))

(defun ntgo-tools-set-devdocs-docs (&rest docs)
  "Set `devdocs-current-docs' for the current buffer to DOCS."
  (setq-local devdocs-current-docs docs))

(use-package devdocs
  :ensure t
  :bind ("C-h D" . devdocs-lookup)
  :config
  (dolist (hook-docs '((python-mode-hook   . ("python~3.12"))
                       (python-ts-mode-hook . ("python~3.12"))
                       (go-ts-mode-hook     . ("go"))
                       (rustic-mode-hook    . ("rust"))
                       (c-mode-hook         . ("c"))
                       (c-ts-mode-hook      . ("c"))
                       (c++-mode-hook       . ("cpp"))
                       (c++-ts-mode-hook    . ("cpp"))
                       (haskell-mode-hook   . ("haskell"))
                       (tuareg-mode-hook    . ("ocaml"))
                       (perl-mode-hook      . ("perl"))
                       (cperl-mode-hook     . ("perl"))
                       (ess-r-mode-hook     . ("r"))))
    (let ((hook (car hook-docs))
          (docs (cdr hook-docs)))
      (add-hook hook
                (lambda ()
                  (apply #'ntgo-tools-set-devdocs-docs docs))))))

;;; Editing and navigation

(use-package avy
  :ensure t
  :bind (("C-:" . avy-goto-char-timer)
         ("s-j" . avy-goto-char-timer)
         ("C-'" . avy-goto-char-2)))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;;; Git

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package diff-hl
  :ensure t
  :hook
  ((prog-mode . diff-hl-mode)
   (dired-mode . diff-hl-dired-mode)
   (magit-pre-refresh . diff-hl-magit-pre-refresh)
   (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type))

;;; Project

;; ASSUMPTION: Emacs 29.1+ is in use; `project-vc-extra-root-markers' was
;; introduced then.  If on 28, replace with a custom `project-find-functions'
;; entry instead.
(use-package project
  :ensure nil
  :config
  (setq project-vc-extra-root-markers
        '("Cargo.toml" "go.mod" "pyproject.toml"
          "package.json" ".project" "dune-project"
	  "compile_commands.json" "CMakeLists.txt")))

(use-package consult-project-extra
  :ensure t)

;;; Terminal

(use-package eat
  :ensure t
  :config
  (eat-eshell-mode)
  (setq eshell-visual-commands '()))

(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

;;; File management

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("<tab>"    . dired-subtree-toggle)
              ("TAB"      . dired-subtree-toggle)
              ("<backtab>" . dired-subtree-remove)
              ("S-TAB"    . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

;;; SQL

(use-package ejc-sql
  :ensure t
  :commands (ejc-connect ejc-disconnect)
  :hook (sql-mode . ejc-sql-mode))

;;; Popup frame utilities

(defun ntgo-window-delete-popup-frame (&rest _)
  "Kill selected frame if it has parameter `ntgo-window-popup-frame'.
Use this function via a hook."
  (when (frame-parameter nil 'ntgo-window-popup-frame)
    (delete-frame)))

(defmacro ntgo-window-define-with-popup-frame (command)
  "Define interactive function which calls COMMAND in a new frame.
Make the new frame have the `ntgo-window-popup-frame' parameter."
  `(defun ,(intern (format "ntgo-window-popup-%s" command)) ()
     ,(format "Run `%s' in a popup frame with `ntgo-window-popup-frame' parameter.
Also see `ntgo-window-delete-popup-frame'." command)
     (interactive)
     (let ((frame (make-frame '((ntgo-window-popup-frame . t) (window-system . x)))))
       (select-frame frame)
       (switch-to-buffer " ntgo-window-hidden-buffer-for-popup-frame")
       (condition-case nil
           (call-interactively ',command)
         ((quit error user-error)
          (delete-frame frame))))))

(declare-function org-capture "org-capture" (&optional goto keys))
(defvar org-capture-after-finalize-hook)
(ntgo-window-define-with-popup-frame org-capture)
(add-hook 'org-capture-after-finalize-hook #'ntgo-window-delete-popup-frame)

(declare-function tmr "tmr" (time &optional description acknowledgep))
(defvar tmr-timer-created-functions)
(ntgo-window-define-with-popup-frame tmr)
(add-hook 'tmr-timer-created-functions #'ntgo-window-delete-popup-frame)

(provide 'ntgo-tools)
;;; ntgo-tools.el ends here
