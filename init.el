;; -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font Propo-12"))

(add-to-list 'default-frame-alist '(alpha-background . 90))

(require 'package)
;; (when (version<= "28.0.50" emacs-version )
;;   (global-display-line-numbers-mode))
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")t)
;; (add-to-list 'package-archives '("org". "https://orgmode.org/elpa/"))
(when (version< emacs-version "28")
  (add-to-list 'package-archives
               '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/my/"))

(customize-set-variable 'package-archive-priorities
                        '(("gnu"    . 99)
                          ("nongnu" . 80)
                          ("stable" . 70)
                          ("melpa"  . 0)))

(require 'use-package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(use-package auto-compile
  :demand t
  :custom
  (auto-compile-check-parens nil)
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package gcmh
  :ensure t
  :hook (after-init . gcmh-mode)
  :custom
  (gcmh-low-cons-threshold (* 2 1000 1000)))

(setq switch-to-buffer-obey-display-actions t)

(defun my/load-config ()
  (progn
    (message "started loading config")
    (recentf-mode 1)
    ;; (repeat-mode)

    (setq-default isearch-yank-on-move t)
    (setq-default set-mark-command-repeat-pop t)
    (setq doc-view-continuous t)
    (global-set-key (kbd "<mouse-2>") 'clipboard-yank)
    (setq x-select-enable-clipboard t)
    (setq create-lockfiles nil)
    (setq visible-bell t)
    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 2)
    (setq electric-pair-pairs
          '(
            (?\" . ?\")
            (?\{ . ?\})))
    (electric-pair-mode 1)
    (setq next-line-add-newlines t)
    (setq display-line-numbers-type 'relative)
    (global-display-line-numbers-mode 1)
    (setq pixel-dead-time 0) ; Never go back to the old scrolling behaviour.
    (setq pixel-resolution-fine-flag t) ; Scroll by number of pixels instead of lines (t = frame-char-height pixels).
    (setq mouse-wheel-scroll-amount '(1)) ; Distance in pixel-resolution to scroll each mouse wheel event.
    (setq mouse-wheel-progressive-speed nil)
    (setq inferior-lisp-program "sbcl")
    (set-default 'truncate-lines t)

    (custom-set-faces
     '(org-level-1 ((t (:inherit outline-1 :foreground "#f6bccc" :height 1.8))))
     '(org-level-2 ((t (:inherit outline-2 :foreground "#c2f0c2" :height 1.5))))
     '(org-level-3 ((t (:inherit outline-3 :foreground "#b6a0ff" :height 1.3))))
     '(org-level-4 ((t (:inherit outline-4 :foreground "#f6bccc" :height 1.1))))
     '(org-level-5 ((t (:inherit outline-5 :foreground "#c2f0c2" :height 1.05)))))
;;(global-set-key (kbd "C-t") ctl-x-map)
    ;;(global-set-key (kbd "M-m") #'mark-sexp)
    ;;(org-babel-load-file (expand-file-name "~/.emacs.d/my-meow.org"))
   ;; (org-babel-load-file (expand-file-name "~/.emacs.d/my-evil-config.org"))
   (org-babel-load-file (expand-file-name "~/.emacs.d/my-init.org"))
    ;;(org-babel-load-file (expand-file-name "~/.emacs.d/ryo-modal.el"))

    (message "config was loaded")))

(add-hook 'after-init-hook
  (lambda () (progn

    (use-package nerd-icons
      ;; :elpaca t
      :defer t
      :ensure t)

    (use-package all-the-icons
      ;; :elpaca t
      :defer t
      :ensure t)

;;     (use-package doom-themes
;;       ;; :elpaca t
;;       :ensure t
;;       :config
;;       ;; Global settings (defaults)
;;       (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;             doom-themes-enable-italic t)  ; if nil, italics is universally disabled
;;       (load-theme 'doom-feather-dark t)
;;       (setq doom-feather-brighter-comments t)
;; ;; (set-face-background 'font-lock-comment-face (doom-lighten "#e68183" 0.4))
;;       ;; Enable flashing mode-line on errors
;;       (doom-themes-visual-bell-config)
;;       ;; Enable custom neotree theme (all-the-icons must be installed!)
;;       (doom-themes-neotree-config)
;;       ;; or for treemacs users
;;       ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;       (doom-themes-treemacs-config)
;;       ;; Corrects (and improves) org-mode's native fontification.
;;       (doom-themes-org-config))

    (use-package my-modeline
      :ensure nil)
    (use-package my-rosepine-moon
      :ensure nil)
    ;; (use-package doom-modeline
    ;;   ;; :elpaca t
    ;;   :ensure t
    ;;   ;; :hook (after-init . doom-modeline-mode)
    ;;   :config
    ;;   (setq doom-modeline-position-line-format nil)
    ;;   (setq doom-modeline-buffer-encoding nil)
    ;;   (doom-modeline-mode))

    ;; (setq doom-modeline-i)
    ;; (custom-set-faces
    ;;   '(mode-line-inactive ((t (:font "DejavuSansM Nerd Font Mono-10" :box (:line-width 1 :height 0.8))))))
    ;; (doom-modeline-mode))
    )))

(use-package spacious-padding
  :ensure t
  :init
  (setq spacious-padding-widths
        '( :internal-border-width 8
           :header-line-width 2
           :mode-line-width 2
           :tab-width 4
           :right-divider-width 10
           :scroll-bar-width 0
           :fringe-width 2))
  (spacious-padding-mode +1))

;; (org-babel-load-file (expand-file-name "~/.emacs.d/my-meow.el"))
;; (org-babel-load-file (expand-file-name "~/.emacs.d/my-evil-config.org"))

;; (run-with-idle-timer 1 nil 'my/load-config)
(my/load-config)
;; (org-babel-load-file (expand-file-name "~/.emacs.d/my-devil.el"))
(setq org-agenda-files '("~/schedule/tasks.org"
                         "~/schedule/events.org"
                         "~/schedule/birthdays.org"))

(setq org-capture-templates
      '(("t" "Tasks / Projects")
        ("tt" "tasks" entry (file+olp "~/schedule/tasks.org" "TASKS")
         "* TODO %?\n %U\n %a\n %i" :empty-lines 1)
        ("tr" "reading" entry (file+olp "~/schedule/tasks.org" "READING")
         "* TODO %?\n %U\n %a\n %i" :empty-lines 1))
      org-agenda-start-with-log-mode t
      org-log-done 'time
      org-log-into-drawer t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(easy-kill-origin ((t (:inherit error :background "white smoke" :foreground "red" :inverse-video t))))
 '(fringe ((t :background "#232136")))
 '(header-line ((t :box (:line-width 2 :color "#2a273f" :style nil))))
 '(header-line-highlight ((t :box (:color "#e0def4"))))
 '(keycast-key ((t)))
 '(line-number ((t :background "#232136")))
 '(mode-line ((t :box (:line-width 2 :color "#484d67" :style nil))))
 '(mode-line-active ((t :box (:line-width 2 :color "#484d67" :style nil))))
 '(mode-line-highlight ((t :box (:color "#e0def4"))))
 '(mode-line-inactive ((t :box (:line-width 2 :color "#292d48" :style nil))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#0d0e1c" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#4a4f6a" :style nil))))
 '(tab-line-tab ((t)))
 '(tab-line-tab-active ((t)))
 '(tab-line-tab-inactive ((t)))
 '(vertical-border ((t :background "#232136" :foreground "#232136")))
 '(window-divider ((t (:background "#232136" :foreground "#232136"))))
 '(window-divider-first-pixel ((t (:background "#232136" :foreground "#232136"))))
 '(window-divider-last-pixel ((t (:background "#232136" :foreground "#232136")))))

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(use-package viper
  ;; :elpaca nil
  :disabled)

(use-package tetris
  ;; :elpaca nil
  :disabled)

(use-package isearchb
  ;; :elpaca nil
  :disabled)


(use-package rect
  ;; :elpaca nil
  :bind
  (:map rectangle-mark-mode-map
        ("t" . string-rectangle)
        ("o" . open-rectangle)
        ("c" . clear-rectangle)
        ("n" . next-line)
        ("p" . previous-line)
        ("f" . forward-char)
        ("b" . backward-char)
        ("x" . rectangle-exchange-point-and-mark)
        (" " . delete-whitespace-rectangle)))

(use-package ps-mode
  ;; :elpaca nil
  :mode (("\\.ps\\'" . ps-mode)))

(use-package ruby-mode
  ;; :elpaca nil
  :mode (("\\.rb\\'" . ruby-mode)))

(use-package verilog-mode
  ;; :elpaca nil
  :mode (("\\.vh\\'" . verilog-mode)
         ("\\.vlg\\'" . verilog-mode)))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)
(setq gc-cons-threshold (* 2 1000 1000))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(anzu-mode-lighter "")
;;  '(anzu-replace-to-string-separator " => ")
;;  '(custom-safe-themes
;;    '("c1d5759fcb18b20fd95357dcd63ff90780283b14023422765d531330a3d3cec2" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d" "6631f884f5f43e9d8eee42f5bcf8522a7f791688d2d2667ec135c129066be243" "93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "467dc6fdebcf92f4d3e2a2016145ba15841987c71fbe675dcfe34ac47ffb9195" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "545ab1a535c913c9214fe5b883046f02982c508815612234140240c129682a68" default))
;;  '(org-fold-core-style 'overlays)
;;  '(package-selected-packages
;;    '(modus-themes mood-line spacious-padding org-modern vertico-posframe consult-denote evil-collection rose-pine-emacs eat tabspaces treesit-auto tree-sitter-langs general evil imenu-list expreg sr-speedbar zop-to-char nerd-icons-corfu zoxide tempel-collection tempel keychain-environment lsp-docker lsp-ui lsp-mode vimish-fold system-packages ednc rainbow-mode consult-eglot eglot git-timemachine nginx-mode openwith docker xterm-color exec-path-from-shell eshell-z elpy python-mode typescript-mode undo-fu-session visual-fill-column nov which-key web-mode vertico use-package undo-tree tide super-save sly rjsx-mode rg rainbow-delimiters puni prettier-js prettier pdf-tools orderless nerd-icons marginalia magit lua-mode key-chord embark-consult dirvish diff-hl denote crux corfu consult-notes cape anzu ansible annalist all-the-icons ace-window))
;; (put 'upcase-region 'disabled nil)

;; (setq initial-buffer-choice "~/.emacs.d/start.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auto-compile gcmh miniedit hydra zoxide zop-to-char xterm-color which-key web-mode visual-fill-column vimish-fold use-package undo-tree undo-fu-session typescript-mode treesit-auto tree-sitter-langs tide tempel-collection tabspaces system-packages sr-speedbar spacious-padding sly rose-pine-emacs rjsx-mode rg rainbow-mode rainbow-delimiters python-mode puni prettier-js prettier pdf-tools org-modern orderless openwith nov nginx-mode nerd-icons-corfu modus-themes marginalia magit lua-mode lsp-ui lsp-docker keychain-environment key-chord imenu-list git-timemachine general expreg exec-path-from-shell evil-collection eshell-z embark-consult elpy ednc eat docker dirvish diff-hl crux corfu consult-notes consult-eglot consult-denote cape anzu ansible all-the-icons ace-window)))
