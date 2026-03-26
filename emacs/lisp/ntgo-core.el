;;; ntgo-core.el --- Core settings and built-in packages -*- lexical-binding: t -*-

;;; Basic settings

(setq load-prefer-newer t)
(setq tab-width 4)
(setq-default require-final-newline t)
(setq browse-url-browser-function 'eww-browse-url)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Local scripts
(add-to-list 'exec-path (concat (getenv "HOME") "/.local/bin"))

;;; Line numbers

(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)

;;; Window management

(windmove-default-keybindings)
(winner-mode)

;;; Persistence

(savehist-mode)
(save-place-mode)
(recentf-mode)

;;; Programming defaults

(add-hook 'prog-mode-hook #'subword-mode)
(add-hook 'prog-mode-hook #'flymake-mode)

;;; Built-in packages

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;;; Custom functions

(defun ntgo/keyboard-quit-dwim ()
  "Quit intelligently depending on context."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

;;; Keybindings

(global-set-key (kbd "C-x k") #'kill-current-buffer)
(global-set-key (kbd "<f3>") #'flymake-goto-next-error)
(global-set-key (kbd "<f5>") #'project-compile)
(global-set-key (kbd "S-<f5>") #'project-recompile)
(define-key global-map (kbd "C-g") #'ntgo/keyboard-quit-dwim)

(provide 'ntgo-core)
;;; ntgo-core.el ends here
