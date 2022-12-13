;; MELPA Package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents))
  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Evil Mode
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
;; Enable Evil
(require 'evil)
(evil-mode 1)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

;; Prevent Emacs Littering!
(unless (package-installed-p 'no-littering)
  (package-install 'no-littering))
(require 'no-littering)
;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)
;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Disable Help Guide Homepage
(setq inhibit-startup-message t ; make help guide doesnt appear on new window
      visible-bell nil)

;; Turn Off UI Elements
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Display Line Numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

;; Theme
;(leaf iceberg-theme
;  :ensure t
;  :config
;  (iceberg-theme-create-theme-file)
;  (load-theme 'solarized-iceberg-dark t))
;(load-theme 'modus-vivendi t)
;(load-theme 'deeper-blue t)

;; Install doom-themes
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))
;; Load up doom-palenight for the System Crafters look
(load-theme 'doom-palenight t)

;; Airline Theme
(unless (package-installed-p 'airline-themes)
  (package-install 'airline-themes))
(require 'airline-themes)
(load-theme 'airline-lucius t)

;; Change Cursor
(setq cursor-type 'box)
(set-cursor-color "#7a96cc") 

;; 6 Basic Emacs Settings
;; Remember Recent File
(recentf-mode 1) ; M-x recentf-open-files
;; Remember MiniBuffer Searches
(setq history-length 25)
(savehist-mode 1) ; M-x or C-s then M-p for previous command, M-n for next command
;; Remember nlast place visited in a file
(save-place-mode 1)
;; Avoid init.el being "corrupted" when u save variables ( M-x customize-save-variable )
(setq custom-file (locate-user-emacs-file "custom-vars.el")) ; Move customization variable to separate file
(load custom-file 'noerror 'nomessage) ; Don't show error if file doesn't exist
;; Don't pop up UI Dialogs when prompting (only on mouse dialogs)
(setq use-dialog-box nil)
;; Revert buffers when underlying files changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t) ; for Dired

;; Org Mode Config
;; Let the desktop background show through
(set-frame-parameter (selected-frame) 'alpha '(97 . 100))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Set reusable font name variables
(defvar my/fixed-width-font "JetBrains Mono"
  "The font to use for monospaced (fixed width) text.")

(defvar my/variable-width-font "Iosevka Aile"
  "The font to use for variable-pitch (document) text.")

;; Fonts
;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
(set-face-attribute 'default nil :font my/fixed-width-font :weight 'light :height 160)
(set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'light :height 180)
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 1.3)

;; Configure Org mode
;; Load org-faces to make sure we can set appropriate faces
(require 'org-faces)

;; Hide emphasis markers on formatted text
(setq org-hide-emphasis-markers t)

;; Resize Org headings
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font my/variable-width-font :weight 'medium :height (cdr face)))

;; Make the document title a bit bigger
(set-face-attribute 'org-document-title nil :font my/variable-width-font :weight 'bold :height 1.3)

;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;;; Centering Org Documents --------------------------------

;; Install visual-fill-column
(unless (package-installed-p 'visual-fill-column)
  (package-install 'visual-fill-column))
;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

;;; Org Present --------------------------------------------

;; Install org-present if needed
(unless (package-installed-p 'org-present)
  (package-install 'org-present))

;; Configure Present Mode Keys
(global-set-key (kbd "<next>") 'org-present-next)
(global-set-key (kbd "<prior>") 'org-present-prev)

;; Collapse Sub-Headers
(defun my/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(defun my/org-present-start ()
  (display-line-numbers-mode -1)
  ; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.3) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))
  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")
  ;; Display inline images automatically
  (org-display-inline-images)
  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/org-present-end ()
  (display-line-numbers-mode 1)
  ;; Reset font customizations
  (setq-local face-remapping-alist '((default variable-pitch default)))
  ;; Clear the header line format by setting to `nil'
  (setq header-line-format nil)
  ;; Stop displaying inline images
  (org-remove-inline-images)
  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

;; Turn on variable pitch fonts in Org Mode buffers
(add-hook 'org-mode-hook 'variable-pitch-mode)

; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)
(add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)

;; Multicursor
(unless (package-installed-p 'evil-multiedit)
  (package-install 'evil-multiedit))
(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

(unless (package-installed-p 'evil-mc)
  (package-install 'evil-mc))
(require 'evil-mc)
;; evil-mc
(global-evil-mc-mode  1) ;; enable

(defun +multiple-cursors/evil-mc-toggle-cursors ()
  "Toggle frozen state of evil-mc cursors."
  (interactive)
  (unless (evil-mc-has-cursors-p)
    (user-error "No cursors exist to be toggled"))
  (setq evil-mc-frozen (not (and (evil-mc-has-cursors-p)
                                 evil-mc-frozen)))
  (if evil-mc-frozen
      (message "evil-mc paused")
    (message "evil-mc resumed")))

(evil-define-key '(normal visual) 'global
  "gzm" #'evil-mc-make-all-cursors
  "gzu" #'evil-mc-undo-all-cursors
  "gzz" #'+multiple-cursors/evil-mc-toggle-cursors
  "gzc" #'evil-mc-make-cursor-here
  "gzn" #'evil-mc-make-and-goto-next-cursor
  "gzp" #'evil-mc-make-and-goto-prev-cursor
  "gzN" #'evil-mc-make-and-goto-last-cursor
  "gzP" #'evil-mc-make-and-goto-first-cursor)
(with-eval-after-load 'evil-mc
  (evil-define-key '(normal visual) evil-mc-key-map
    (kbd "C-n") #'evil-mc-make-and-goto-next-cursor
    (kbd "C-N") #'evil-mc-make-and-goto-last-cursor
    (kbd "C-p") #'evil-mc-make-and-goto-prev-cursor
    (kbd "C-P") #'evil-mc-make-and-goto-first-cursor))

