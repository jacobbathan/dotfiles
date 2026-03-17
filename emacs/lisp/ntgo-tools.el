;;; ntgo-tools.el --- Editing tools and utilities -*- lexical-binding: t -*-

;;; Text formats

(use-package markdown-mode
  :ensure t)

;;; Git

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

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

;;; AI

(use-package ellama
  :ensure t
  :init
  (setopt ellama-keymap-prefix "C-c e"))

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
