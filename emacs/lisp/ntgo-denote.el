;;; ntgo-denote.el --- Denote Zettelkasten configuration -*- lexical-binding: t -*-

;;; Denote core

(use-package denote
  :ensure t
  :custom
  (denote-directory (expand-file-name "~/Notes/org/"))
  (denote-known-keywords '("fleeting" "literature" "permanent" "reference"
                           "seedling" "budding" "evergreen"
                           "tech" "devops" "python" "go" "rust"
                           "career" "systems" "networking" "life"
                           "concepts" "creative"))
  (denote-infer-keywords t)
  (denote-sort-keywords t)
  (denote-file-type 'org)
  (denote-date-prompt-use-org-read-date t)
  (denote-backlinks-show-context t)
  (denote-templates
   '((fleeting . "")
     (literature . "Source: \n\n(Summary in your own words)\n\n* What I want to explore further\n- ")
     (permanent . "(Explain the concept in plain language — no code first)\n\n#+begin_src \n\n#+end_src\n\n* Related\n- ")
     (reference . "(Brief description of this topic area)\n\n* Core Concepts\n#+BEGIN: denote-links :regexp \"_KEYWORD.*_permanent\" :sort-by-component title\n#+END:\n\n* Open Questions\n- \n\n* Sources\n- ")
     (debug-log . "* Symptom\n\n\n* Investigation\n\n\n* Root Cause\n\n\n* Fix\n#+begin_src \n\n#+end_src\n\n* Lesson\n\n\n* Related\n- ")))
  :config
  ;; Rename buffers to show note title instead of raw filename
  (denote-rename-buffer-mode 1))

;;; Denote-Org (dynamic blocks, subtree-to-note, heading backlinks)

(use-package denote-org
  :ensure t
  :after denote)

;;; Denote-Journal

(use-package denote-journal
  :ensure t
  :after denote
  :custom
  (denote-journal-directory (expand-file-name "~/Notes/org/journal/"))
  (denote-journal-keyword "journal")
  (denote-journal-interval 'daily)
  (denote-journal-title-format 'day-date-month-year))

;;; Denote-Explore (statistics, random walks, janitor, network graphs)

(use-package denote-explore
  :ensure t
  :after denote
  :custom
  (denote-explore-network-directory (expand-file-name "~/Notes/org/.network/"))
  (denote-explore-network-format 'd3.js))

;;; Consult-Notes (fuzzy search across all notes via Consult)

(use-package consult-notes
  :ensure t
  :after (denote consult)
  :custom
  (consult-notes-file-dir-sources
   '(("Denote" ?d "~/Notes/org/")))
  :config
  ;; Use ripgrep for full-text search
  (setq consult-notes-use-rg t))

;;; Dired fontification inside Notes directory

(defun ntgo-denote-enable-dired-mode ()
  "Enable `denote-dired-mode' when visiting the notes directory."
  (when (string-prefix-p (expand-file-name "~/Notes/org/")
                         (expand-file-name default-directory))
    (denote-dired-mode 1)))

(add-hook 'dired-mode-hook #'ntgo-denote-enable-dired-mode)

;;; Keybindings — C-c n prefix

(defvar-keymap ntgo-denote-map
  :doc "Prefix keymap for Denote note commands."
  "n" #'denote-open-or-create
  "c" #'org-capture
  "f" #'consult-notes
  "s" #'consult-notes-search-in-all-notes
  "i" #'denote-link-or-create
  "l" #'denote-find-link
  "b" #'denote-backlinks
  "r" #'denote-rename-file
  "R" #'denote-rename-file-using-front-matter
  "j" #'denote-journal-new-or-existing-entry
  "d" #'denote-org-dblock-insert-links)

(defvar-keymap ntgo-denote-explore-map
  :doc "Sub-keymap for denote-explore commands."
  "r" #'denote-explore-random-note
  "s" #'denote-explore-sync-metadata
  "n" #'denote-explore-network
  "c" #'denote-explore-count-notes)

(define-key ntgo-denote-map "e" ntgo-denote-explore-map)
(global-set-key (kbd "C-c n") ntgo-denote-map)

(provide 'ntgo-denote)
;;; ntgo-denote.el ends here
