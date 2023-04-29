
;; (global-set-key (kbd ",") nil)
;; (global-set-key (kbd ", SPC") #'(lambda () (interactive) (insert ", ")))
;; (global-set-key (kbd ", j") #'hydra-vi/body)

;; (global-set-key (kbd ";") nil)
;; (global-set-key (kbd "; <return>") #'(lambda () (interactive) (insert ";\n")))
;; (define-key god-local-mode-map (kbd ",") nil)

;; (defhydra hydra-insert ()
;;   "insert"
;;   (";" (lambda () (interactive) (insert ";")))
;;   ("," (lambda () (interactive) (insert ",")))
;;   ("q" nil "quit"))
;; (global-set-key (kbd "; i") hydra-insert/body)

(use-package browse-kill-ring
  :after (god-mode)
  :ensure t
  :bind (("M-y" . browse-kill-ring)))

;; (use-package easy-kill
;;   :after (god-mode)
;;   :ensure t
;;   :bind (("M-w" . easy-kill)
;;          (:map god-local-mode-map
;;                ("m" . easy-kill))
;;          (:map easy-kill-base-map
;;                ("d" . easy-kill-region)
;;                ("j" . easy-kill-expand)
;;                ("k" . easy-kill-shrink)
;;                ("SPC" . easy-kill-cycle)
;;                ("m" . easy-kill-mark-region)))
;;   :config
;;   (setq easy-kill-alist '((?w word           " ")
;;                              (?s sexp           "\n")
;;                              (?l list           "\n")
;;                              ;;(?f filename       "\n")
;;                              (?f defun          "\n\n")
;;                              (?F defun-name     " ")
;;                              (?e line           "\n")
;;                              (?b buffer-file-name)))
;;   (set-face-foreground 'secondary-selection (face-foreground 'avy-lead-face))
;;   (set-face-background 'secondary-selection (face-background 'avy-lead-face)))

(use-package crux
  :after (god-mode)
  :ensure t
  :bind (("C-a" . crux-move-beginning-of-line)
         ("C-o" . crux-smart-open-line)
         ("C-S-o" . crux-smart-open-line-above)
         ("M-o" . crux-other-window-or-switch-buffer)))

(use-package selected
  :after (god-mode)
  :ensure t
  :commands selected-minor-mode
  :init
  (selected-global-mode)
  (setq selected-org-mode-map (make-sparse-keymap))
  :bind (:map selected-keymap
              ("C-q" . selected-off)
              ("C-u" . upcase-region)
              ("M-l" . downcase-region)
              ("d" . kill-region)
              ;;("C-w" . copy-region-as-kill)
              ("C-m" . apply-macro-to-region-lines)
              :map selected-org-mode-map
              ("t" . org-table-convert-region)))

(use-package expand-region
  :after (god-mode)
  :ensure t
  :after (selected)
  :bind (("C-=" .  er/expand-region)
         :map selected-keymap
         ("C-)" . er/mark-inside-pairs)
         ("C-'" . er/mark-inside-quotes)))

;; (defvar isearch-repeat-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "s") #'isearch-repeat-forward)
;;     (define-key map (kbd "r") #'isearch-repeat-backward)
;;     map))

;;  (dolist (cmd '(isearch-repeat-forward isearch-repeat-backward))
;;    (put cmd 'repeat-map 'isearch-repeat-map))


(use-package god-mode
  :defer t
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
  (define-key isearch-mode-map (kbd "x") #'god-mode-isearch-activate)
  
  (define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)
  (define-key god-mode-isearch-map (kbd "x") #'(lambda () "insert-x in isearch" (interactive) (progn (isearch-printing-char (string-to-char "x")) (god-mode-isearch-disable))))  
  (define-key god-mode-isearch-map (kbd "5") #'anzu-isearch-query-replace)
  (define-key god-mode-isearch-map (kbd "o") #'isearch-occur)
    
  (define-key god-local-mode-map (kbd "i") #'god-mode-all)
  (define-key god-local-mode-map (kbd ".") #'repeat)

  ;;(define-key god-local-mode-map (kbd "M-k") #'kill-line)
  (define-key god-local-mode-map (kbd "C-S-E") #'end-of-line)
  (define-key god-local-mode-map (kbd "C-S-A") #'beginning-of-line)
  (define-key god-local-mode-map (kbd "C-S-F") #'forward-char)
  (define-key god-local-mode-map (kbd "C-S-B") #'backward-char)
  (define-key god-local-mode-map (kbd "C-S-N") #'next-line)
  (define-key god-local-mode-map (kbd "C-S-P") #'previous-line)

  (define-key god-local-mode-map (kbd ";") nil)
  (define-key god-local-mode-map (kbd "; '") #'match-paren)
  (define-key god-local-mode-map (kbd "; i") #'imenu)
  (define-key god-local-mode-map (kbd "; x f") #'rgrep)


  (define-key god-local-mode-map (kbd "h") nil)
  ;;(define-key god-local-mode-map (kbd "l") #'forward-char)
  
  ;;(define-key god-local-mode-map (kbd "w") #'forward-word)

  (define-key god-local-mode-map (kbd "d") nil)
  (define-key god-local-mode-map (kbd "d d") #'crux-smart-kill-line)
  (define-key god-local-mode-map (kbd "d s") #'zap-to-char)
  (define-key god-local-mode-map (kbd "d t") #'zap-up-to-char)
  (define-key god-local-mode-map (kbd "d l") #'delete-char)
  
(defun my-god-mode-update-cursor-type ()
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)



(setq god-mod-alist
    '((nil . "C-")
    ("m" . "M-")
    ("g" . "C-M-")
    ))

;; (defun reset-god-mod-alist ()
;;   "set god-mode alist back to a default"
;;   (interactive)
;;   (setq god-mod-alist
;;     '((nil . "C-")
;;     ("g" . "M-")
;;     ("G" . "C-M-")
;;     (";" . "A-"))))

;;(global-set-key (kbd "C-x A-;") (kbd "C-x C-;"))

(define-key isearch-mode-map (kbd "'") 'isearch-exit)

(define-key god-mode-isearch-map (kbd ";") 'avy-isearch)

 (defun dwim/goto-char (arg char)
    "Move pointer up to and including ARG'th occurrence of CHAR.
            Case is ignored if `case-fold-search' is non-nil in the current buffer.
            Goes backward if ARG is negative; error if CHAR not found."
    (interactive "p\ncchar: ")
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char)))
    (progn (search-forward (char-to-string char)
                           nil nil arg) (point)))

;; (define-minor-mode vimish-movement-mode
;;               "Minor mode to recreate Vim style movements in god mode"
;;               :lighter " Vimish"
;;               :keymap (let ((map (make-sparse-keymap)))
;;                         (define-key map (kbd "C-j") 'next-line)
;;                         (define-key map (kbd "C-k") 'previous-line)
;;                         (define-key map (kbd "C-h") 'backward-char)
;;                         (define-key map (kbd "C-l") 'forward-char)
;;                         (define-key map (kbd "C-w") 'forward-word)
;;                         (define-key map (kbd "C-f") 'dwim/goto-char)
;;                         (define-key map (kbd "C-b") 'backward-word)
;;                         map))

(defvar xah-brackets '("“”" "()" "[]" "{}" "<>" "＜＞" "（）" "［］" "｛｝" "❛❜" "❝❞" "❨❩" "❪❫" "❴❵" "❬❭" "❮❯" "❰❱"))

  ;; "A list of strings, each element is a string of (defconst xah-right-brackets
  ;; (mapcar (lambda (x) (substring x 1 2)) xah-brackets)

(defconst xah-left-brackets
  (mapcar (lambda (x) (substring x 0 1)) xah-brackets)
  "List of left bracket chars. Each element is a string.")

;; (defun forward-left-bracket ()
;;   "Move cursor to the next occurrence of left bracket.
;; The list of brackets to jump to is defined by `xah-right-brackets'.
;; URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
;; Version 2015-10-01"
;;   (interactive)
;;   (re-search-forward (regexp-opt xah-left-brackets) nil t))

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

(defhydra hydra-vi ()
  "vi"
  ("l" forward-char)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)
  ("m" easy-kill)
  ("v" rectangle-mark-mode)
  ("SPC" hydra-paragraph/body :exit t)
  ("q" nil "quit"))

(defhydra hydra-paragraph (:color red :hint nil)
    ""
  ("q" nil)
  ("l" forward-word "forward")
  ("j" forward-paragraph "next")
  ("k" backward-paragraph "prev")
  ("h" backward-word "backard")
  ("SPC" hydra-vi/body :exit t)
  ("m" set-mark-command "mark"))

(define-key god-local-mode-map (kbd "h l") 'hydra-bracket-mov/body)
(define-key god-local-mode-map (kbd "h j") 'hydra-vi/body)


(defhydra hydra-search (:color red :hint nil)
    ""
  ("q" nil)
  ("s" isearch-repeat-forward "forward")
  ("r" isearch-repeat-backward "backward")
  ("j" avy-next "avy-next")
  ("k" avy-prev "avy-prev")
  ("." isearch-forward-thing-at-point "at point")
  ("m" set-mark-command "mark"))

(define-key god-local-mode-map (kbd "h s") 'hydra-search/body)

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

(defhydra hydra-bracket-mov (:color red :hint nil)
    "
^By List^             ^By Level^           ^Actions^  
^^^^^^^^----------------------------------------------
_j_: next          _h_: higher        _SPC_: vi 
_k_: prev          _l_: lower         _m_: mark-sexp
_e_: end-of        _w_: avy-word                ^ ^
"
  ("q" nil)
  (";" nil)
  ("j" my/smart-forward-list)
  ("k" backward-list)
  ("h" backward-up-list)
  ("l" down-list)
  ("e" forward-list)
  ("w" avy-goto-word-1 :exit t)
  ("m" easy-mark-sexp)
  ("SPC" hydra-vi/body :exit t))

(defhydra hydra-avy (:color teal :hint nil)
  "
^^             ^^           ^^  
^^^^^^^^----------------------------------------------
_j_: char          _SPC_: ws        _s_: timer 
_w_: word-0        _l_: line        _r_: region
_e_: word-1        _f_: char-inline                ^ ^
"
  ("j" avy-goto-char)
  ("w" avy-goto-word-0 )
  ("SPC" avy-goto-whitespace-end)
  ("e" avy-goto-word-1 )
  ("l" avy-goto-line)
  ("s" avy-goto-char-timer)
  ("r" avy-kill-ring-save-region )
  ("f" avy-goto-char-in-line)
  ("q" nil))

(define-key god-local-mode-map (kbd "h n") #'hydra-paragraph/body)
(define-key god-local-mode-map (kbd "h a") #'hydra-avy/body)

;; (defun avy-extend-command (repeat-arg)
;;   "Runs a specific avy command based on what the last-repeatable-command was"
;;   (interactive "P")
;;   (pcase last-repeatable-command
;;    ('next-line
;;     (avy-goto-line-below))
;;    ('previous-line
;;     (avy-goto-line-above))
;;    ('forward-char
;;     (avy-goto-word-0-below-in-line))
;;    ('forward-word
;;     (avy-goto-word-0-below-in-line))
;;    ('backward-char
;;     (avy-goto-word-0-above-in-line))
;;    ('backward-word
;;     (avy-goto-word-0-above-in-line))
;;    ('forward-left-bracket
;;     (avy-goto-open-brackets))))

;;(global-set-key (kbd "A-j") #')
;(gglobal-set-key (kbd "H-;") #'vimish-movement-mode)
;;(global-set-key (kbd "H-l") #'bracket-movement-mode)
;; (global-set-key (kbd "H-n") #'forward-left-bracket)
;; (global-set-key (kbd "H-p") #'xah-backward-left-bracket)
;;(global-set-key (kbd "A-s") #'avy-goto-char-timer)

)

(add-hook 'after-init-hook 'god-mode-all)
