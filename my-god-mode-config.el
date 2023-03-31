
(use-package browse-kill-ring
  :ensure t
  :bind (("M-y" . browse-kill-ring)))

(use-package easy-kill
  :ensure t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (define-key easy-kill-base-map (kbd "C-SPC") 'easy-kill-cycle)
  (define-key easy-kill-base-map (kbd "SPC") 'easy-kill-mark-region))

(use-package crux
  :ensure t
  :bind (("C-a" . crux-move-beginning-of-line)
         ("C-o" . crux-smart-open-line)
         ("C-S-o" . crux-smart-open-line-above)))

(use-package selected
  :ensure t
  :commands selected-minor-mode
  :init
  (selected-global-mode)
  (setq selected-org-mode-map (make-sparse-keymap))
  :bind (:map selected-keymap
              ("C-q" . selected-off)
              ("C-u" . upcase-region)
              ("M-l" . downcase-region)
              ("C-d" . kill-region)
              ("C-w" . copy-region-as-kill)
              ("C-m" . apply-macro-to-region-lines)
              ;; ("C-)" . er/mark-inside-pairs)
              ;; ("C-'" . er/mark-inside-quotes)
              :map selected-org-mode-map
              ("t" . org-table-convert-region)))

(use-package expand-region
  :ensure t
  :bind ("C-=" .  er/expand-region)
  :init
  (define-key selected-keymap (kbd "C-)") 'er/mark-inside-pairs)
  (define-key selected-keymap (kbd "C-'") #'er/mark-inside-quotes))

(defvar isearch-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") #'isearch-repeat-forward)
    (define-key map (kbd "r") #'isearch-repeat-backward)
    map))

 (dolist (cmd '(isearch-repeat-forward isearch-repeat-backward))
   (put cmd 'repeat-map 'isearch-repeat-map))


(use-package god-mode
  :ensure t
  :config
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (global-set-key (kbd "C-x C-1") #'delete-other-windows)
  (global-set-key (kbd "C-x C-2") #'split-window-below)
  (global-set-key (kbd "C-x C-3") #'split-window-right)
  (global-set-key (kbd "C-x C-0") #'delete-window)
  (global-set-key (kbd "C-x C-b") #'switch-to-buffer)
  (global-set-key (kbd "C-x C-(") #'kmacro-start-macro)
  (global-set-key (kbd "C-x C-)") #'kmacro-end-macro)



  
  (define-key god-local-mode-map (kbd "[") #'backward-paragraph)
  (define-key god-local-mode-map (kbd "]") #'forward-paragraph)
  (global-set-key (kbd "<escape>") #'god-mode-all)
  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") #'god-mode-isearch-activate)
  (define-key isearch-mode-map (kbd "C-i") #'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)
  (define-key god-mode-isearch-map (kbd "5") #'anzu-isearch-query-replace)
  (define-key god-mode-isearch-map (kbd "o") #'isearch-occur)
  
  (define-key god-local-mode-map (kbd "i") #'god-mode-all)
  (define-key god-local-mode-map (kbd ".") #'repeat)
  ;; (define-key god-local-mode-map (kbd "C-k") #'backward-paragraph)
  ;; (define-key god-local-mode-map (kbd "C-j") #'forward-paragraph)
  (define-key god-local-mode-map (kbd "M-k") #'kill-line)
  (define-key god-local-mode-map (kbd "C-S-E") #'end-of-line)
  (define-key god-local-mode-map (kbd "C-S-A") #'beginning-of-line)
  (define-key god-local-mode-map (kbd "C-S-F") #'forward-char)
  (define-key god-local-mode-map (kbd "C-S-B") #'backward-char)
  (define-key god-local-mode-map (kbd "C-S-N") #'next-line)
  (define-key god-local-mode-map (kbd "C-S-P") #'previous-line)
  (define-key god-local-mode-map (kbd "H-'") #'match-paren))

(defun my-god-mode-update-cursor-type ()
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)
  
(setq god-mod-alist
    '((nil . "C-")
    ("g" . "M-")
    ("G" . "C-M-")
    (";" . "H-")))

(defun reset-god-mod-alist ()
  "set god-mode alist back to a default"
  (interactive)
  (setq god-mod-alist
    '((nil . "C-")
    ("g" . "M-")
    ("G" . "C-M-")
    (";" . "H-"))))

(global-set-key (kbd "C-x H-;") (kbd "C-x C-;"))

  (define-key isearch-mode-map (kbd "'") 'isearch-exit)

(define-key isearch-mode-map (kbd ";") 'avy-isearch)

 (defun dwim/goto-char (arg char)
    "Move pointer up to and including ARG'th occurrence of CHAR.
            Case is ignored if `case-fold-search' is non-nil in the current buffer.
            Goes backward if ARG is negative; error if CHAR not found."
    (interactive "p\ncchar: ")
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char)))
    (progn (search-forward (char-to-string char)
                           nil nil arg) (point)))

(define-minor-mode vimish-movement-mode
              "Minor mode to recreate Vim style movements in god mode"
              :lighter " Vimish"
              :keymap (let ((map (make-sparse-keymap)))
                        (define-key map (kbd "C-j") 'next-line)
                        (define-key map (kbd "C-k") 'previous-line)
                        (define-key map (kbd "C-h") 'backward-char)
                        (define-key map (kbd "C-l") 'forward-char)
                        (define-key map (kbd "C-w") 'forward-word)
                        (define-key map (kbd "C-f") 'dwim/goto-char)
                        (define-key map (kbd "C-b") 'backward-word)
                        map))

(defvar xah-brackets '("“”" "()" "[]" "{}" "<>" "＜＞" "（）" "［］" "｛｝" "❛❜" "❝❞" "❨❩" "❪❫" "❴❵" "❬❭" "❮❯" "❰❱"))

  ;; "A list of strings, each element is a string of (defconst xah-right-brackets
  ;; (mapcar (lambda (x) (substring x 1 2)) xah-brackets)

(defconst xah-left-brackets
  (mapcar (lambda (x) (substring x 0 1)) xah-brackets)
  "List of left bracket chars. Each element is a string.")

(defun forward-left-bracket ()
  "Move cursor to the next occurrence of left bracket.
The list of brackets to jump to is defined by `xah-right-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-forward (regexp-opt xah-left-brackets) nil t))

(defconst xah-right-brackets
  (mapcar (lambda (x) (substring x 1 2)) xah-brackets)
  "List of right bracket chars. Each element is a string.")

(defun xah-backward-left-bracket ()
  "Move cursor to the previous occurrence of left bracket.
The list of brackets to jump to is defined by `xah-left-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-backward (regexp-opt xah-left-brackets) nil t))

(defun forward-left-bracket ()
  "Move cursor to the next occurrence of left bracket.
The list of brackets to jump to is defined by `xah-right-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-forward (regexp-opt xah-left-brackets) nil t))

(defun my/smart-forward-list (arg)
  "Move to the start of the next list"
  (interactive "p")
  (if (looking-at "\\s(")
      (progn
        (forward-list 2)
        (backward-list 1))
    (progn 
      (re-search-forward (regexp-opt xah-left-brackets) (looking-at (regexp-opt xah-right-brackets)) t)
      (backward-char 1))))

;; (define-minor-mode bracket-movement-mode
;;               "Minor mode to move across lists god mode"
;;               :lighter " {bracket}"
;;               :keymap (let ((map (make-sparse-keymap)))
;;                         (define-key map (kbd "C-j") 'my/smart-forward-list)
;;                         (define-key map (kbd "C-k") 'backward-list)
;;                         (define-key map (kbd "C-h") 'backward-up-list)
;;                         (define-key map (kbd "C-l") 'down-list)
;;                         (define-key map (kbd "C-e") 'forward-list)
;;                         map))


(global-set-key (kbd "H-l") 'hydra-bracket-mov/body)

(defun xah-forward-right-bracket ()
  "Move cursor to the next occurrence of right bracket.
The list of brackets to jump to is defined by `xah-right-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-forward (regexp-opt xah-right-brackets) nil t))

(defun avy-goto-open-brackets ()
  (interactive)
  (let ((avy-command this-command))   ; for look up in avy-orders-alist
    (avy-jump (regexp-opt xah-left-brackets))))

(defun avy-goto-word-0-below-in-line ()
  "Jump forward to words in the current line"
  (interactive)
  (avy-with avy-goto-word-0
    (avy-goto-word-0 nil (point) (line-end-position))))

(defun avy-goto-word-0-above-in-line ()
  "Jump forward to words in the current line"
  (interactive)
  (avy-with avy-goto-word-0
    (avy-goto-word-0 nil (line-beginning-position) (point))))

;;(avy-jump (regexp-opt xah-left-brackets))

(defhydra hydra-bracket-mov (:color red :hint nil)
    "
^By List^             ^By Level^           ^Actions^  
^^^^^^^^----------------------------------------------
_j_: next          _h_: higher        _SPC_: set-mark 
_k_: prev          _l_: lower         ^ ^
_e_: end-of        _a_: avy-word                ^ ^
"
  ("q" nil)
  ("j" my/smart-forward-list)
  ("k" backward-list)
  ("h" backward-up-list)
  ("l" down-list)
  ("e" forward-list)
  ("a" avy-goto-word-0-below-in-line)
  ("SPC" set-mark-command))

(defun avy-extend-command (repeat-arg)
  "Runs a specific avy command based on what the last-repeatable-command was"
  (interactive "P")
  (pcase last-repeatable-command
   ('next-line
    (avy-goto-line-below))
   ('previous-line
    (avy-goto-line-above))
   ('forward-char
    (avy-goto-word-0-below-in-line))
   ('forward-word
    (avy-goto-word-0-below-in-line))
   ('backward-char
    (avy-goto-word-0-above-in-line))
   ('backward-word
    (avy-goto-word-0-above-in-line))
   ('forward-left-bracket
    (avy-goto-open-brackets))))

(global-set-key (kbd "H-j") #'avy-extend-command)
(global-set-key (kbd "H-;") #'vimish-movement-mode)
;;(global-set-key (kbd "H-l") #'bracket-movement-mode)
;; (global-set-key (kbd "H-n") #'forward-left-bracket)
;; (global-set-key (kbd "H-p") #'xah-backward-left-bracket)
(global-set-key (kbd "H-s") #'avy-goto-char-timer)


;; (global-set-key (kbd "H-h") #'(lambda () (interactive) (setq god-mod-alist '(
;;     (nil . "H-")
;;     ("g" . "M-")
;;     ("G" . "C-M-")
;;     ("h" . "C-")))))

;; (global-set-key (kbd "H-c") #'reset-god-mod-alist)
