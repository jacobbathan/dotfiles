;;; ntgo-org.el --- Org mode and RSS -*- lexical-binding: t -*-

;;; Org core

(use-package org
  :ensure nil
  :config
  (setq org-M-RET-may-split-line '((default . nil)))
  (setq org-insert-heading-respect-content t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-directory "~/Notes/org")
  (setq org-agenda-files (list org-directory))
  (setq org-babel-python-command "python3")
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (R      . t)
     (sql    . t)
     (shell  . t)))
  :custom
  (org-list-allow-alphabetical-list t)
  (org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n!)" "WAITING(w!)" "|" "DONE(d!)" "CANCELLED(c!)")))
  :bind
  ("C-c a" . org-agenda))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode))

(use-package org-modern
  :ensure t
  :hook (org-mode . global-org-modern-mode)
  :custom
  (org-modern-keyword nil)
  (org-modern-checkbox nil)
  (org-modern-table nil))

(setq-default org-startup-indented t
              org-pretty-entities t
              org-use-sub-superscripts "{}"
              org-hide-emphasis-markers t
              org-startup-with-inline-images t
              org-image-actual-width '(300))

;;; LaTeX previews

(use-package org-fragtog
  :ensure t
  :after org
  :hook (org-mode . org-fragtog-mode)
  :custom
  (org-startup-with-latex-preview t)
  (org-format-latex-options
   (plist-put org-format-latex-options :scale 2)
   (plist-put org-format-latex-options :foreground 'auto)
   (plist-put org-format-latex-options :background 'auto)))

;;; Distraction-free writing

(defun distraction-free ()
  "Distraction-free writing environment using Olivetti package."
  (interactive)
  (if (equal olivetti-mode nil)
      (progn
        (window-configuration-to-register 1)
        (delete-other-windows)
        (text-scale-set 2)
        (olivetti-mode t))
    (progn
      (if (eq (length (window-list)) 1)
          (jump-to-register 1))
      (olivetti-mode 0)
      (text-scale-set 0))))

(use-package olivetti
  :ensure t
  :demand t
  :bind ("<f9>" . distraction-free))

;;; Org-indent for cleaner visual indentation

(add-hook 'org-mode-hook #'org-indent-mode)

;;; Capture and export

(use-package org-capture
  :ensure nil
  :bind ("C-c c" . org-capture)
  :config
  (setq org-capture-templates
        '(("t" "[T]ask")
          ("st" "Scheduled Task" entry
           (file+headline "todo/todo.org" "All Tasks")
           "* TODO %? SCHEDULED: %^t %^G \n:CAPTURED: %U" :empty-lines 1)

          ;; --- Denote note captures ---
          ;; Each lambda pre-sets `denote-use-*' variables (the v4.x API) before
          ;; calling `denote-org-capture', which reads those vars instead of prompting.
          ;; Directories must be absolute paths under `denote-directory'.

          ("n" "[N]otes (Denote)")

          ("nf" "Fleeting note" plain
           (file denote-last-path)
           (function (lambda ()
             (let ((denote-use-directory (expand-file-name "inbox" (denote-directory)))
                   (denote-use-keywords '("fleeting"))
                   (denote-use-template 'fleeting))
               (denote-org-capture))))
           :no-save nil
           :kill-buffer t)

          ("nl" "Literature note" plain
           (file denote-last-path)
           (function (lambda ()
             (let ((denote-use-directory (expand-file-name "resources/literature" (denote-directory)))
                   (denote-use-keywords '("literature"))
                   (denote-use-template 'literature))
               (denote-org-capture))))
           :no-save t
           :immediate-finish nil
           :kill-buffer t
           :jump-to-captured t)

          ("np" "Permanent note" plain
           (file denote-last-path)
           (function (lambda ()
             (let* ((sub (completing-read "Subdir under resources/permanent/: "
                                          '("tech" "concepts" "career" "life" "creative")
                                          nil t))
                    (denote-use-directory (expand-file-name
                                           (concat "resources/permanent/" sub)
                                           (denote-directory)))
                    (denote-use-keywords '("permanent"))
                    (denote-use-template 'permanent))
               (denote-org-capture))))
           :no-save t
           :immediate-finish nil
           :kill-buffer t
           :jump-to-captured t)

          ("nr" "Reference note (hub/wiki)" plain
           (file denote-last-path)
           (function (lambda ()
             (let ((denote-use-directory (expand-file-name "reference" (denote-directory)))
                   (denote-use-keywords '("reference"))
                   (denote-use-template 'reference))
               (denote-org-capture))))
           :no-save t
           :immediate-finish nil
           :kill-buffer t
           :jump-to-captured t)

          ("nd" "Debug log" plain
           (file denote-last-path)
           (function (lambda ()
             (let ((denote-use-directory (expand-file-name "resources/permanent/tech" (denote-directory)))
                   (denote-use-keywords '("permanent"))
                   (denote-use-template 'debug-log))
               (denote-org-capture))))
           :no-save t
           :immediate-finish nil
           :kill-buffer t
           :jump-to-captured t)

          ;; Journal: org-capture just delegates to the denote-journal command.
          ;; The capture "completes" immediately; the real work is opening the journal file.
          ("nj" "Journal entry" plain
           (function (lambda ()
                       (denote-journal-new-or-existing-entry)
                       (goto-char (point-max))))
           ""
           :immediate-finish t))))

(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox)

;;; Jupyter babel integration

;; ASSUMPTION: the MELPA package is named `jupyter' (emacs-jupyter).
;; Install the kernel-side dep with: pip install jupyter_client ipykernel
;; ob-jupyter is registered here so `#+begin_src jupyter-python' etc. work.
(use-package jupyter
  :ensure t
  :after org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((jupyter . t)))))

(use-package ox-odt
  :ensure nil
  :config
  (add-to-list 'auto-mode-alist
               '("\\.\\(?:OD[CFIGPST]\\|od[cfigpst]\\)\\'" . doc-view-mode-maybe)))

;;; Document viewing

(use-package doc-view
  :ensure nil
  :custom
  (doc-view-resolution 300)
  (doc-view-mupdf-use-svg t)
  (large-file-warning-threshold (* 50 (expt 2 20))))

(use-package nov
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;;; RSS / Elfeed

(use-package elfeed
  :ensure t
  :bind
  (("C-c w e" . elfeed)
   ("C-c w u" . elfeed-update))
  :custom
  (elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory))
  (elfeed-show-entry-switch 'display-buffer))

(setq-default elfeed-search-filter "@1-week-ago +unread")

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  :custom
  (rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org")))

(use-package org-web-tools
  :ensure t
  :bind ("C-c w w" . org-web-tools-insert-link-for-url))

(use-package elfeed-tube
  :ensure t
  :after elfeed
  :demand t
  :config
  (elfeed-tube-setup)
  :bind (:map elfeed-show-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)
              :map elfeed-search-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)))

(use-package elfeed-tube-mpv
  :ensure t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(use-package mpv
  :ensure t)

(provide 'ntgo-org)
;;; ntgo-org.el ends here
