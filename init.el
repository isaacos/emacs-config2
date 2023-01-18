(global-set-key (kbd "<mouse-2>") 'clipboard-yank)
(setq x-select-enable-clipboard t)
(setq create-lockfiles nil)
(require 'package)
(setq inferior-lisp-program "sbcl")
(setq visible-bell t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq electric-pair-pairs
      '(
      (?\" . ?\")
        (?\{ . ?\})))
(electric-pair-mode 1)
(setq next-line-add-newlines t)

(setq cursor-type 'hbar)

(add-to-list 'default-frame-alist '(width  . 90))
(add-to-list 'default-frame-alist '(height  . 30))
(add-to-list 'default-frame-alist '(font . "Fira Code Retina-12"))

(setq pixel-dead-time 0) ; Never go back to the old scrolling behaviour.
(setq pixel-resolution-fine-flag t) ; Scroll by number of pixels instead of lines (t = frame-char-height pixels).
(setq mouse-wheel-scroll-amount '(1)) ; Distance in pixel-resolution to scroll each mouse wheel event.
(setq mouse-wheel-progressive-speed nil)

(tab-bar-mode t)
(set-default 'truncate-lines t)
(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(recentf-mode 1)

(when (version<= "28.0.50" emacs-version )
  (global-display-line-numbers-mode))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")t)
(add-to-list 'package-archives '("org". "https://orgmode.org/elpa/"))
(require 'use-package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(org-babel-load-file (expand-file-name "~/.emacs.d/my-init.org"))
