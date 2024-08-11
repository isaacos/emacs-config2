(provide 'useful-hydras)

(defvar xah-brackets '("“”" "()" "[]" "{}" "<>" "＜＞" "（）" "［］" "｛｝" "❛❜" "❝❞" "❨❩" "❪❫" "❴❵" "❬❭" "❮❯" "❰❱" "\"\""))

              (defconst xah-left-brackets
                (mapcar (lambda (x) (substring x 0 1)) xah-brackets)
                "List of left bracket chars. Each element is a string.")

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

(defun xah-forward-right-bracket ()
  "Move cursor to the next occurrence of right bracket.
              The list of brackets to jump to is defined by `xah-right-brackets'.
              URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
              Version 2015-10-01"
  (interactive)
  (re-search-forward (regexp-opt xah-right-brackets) nil t))

(defun avy-goto-xah-open ( &optional arg)
  "Jump to the currently visible CHAR.
The window scope is determined by `avy-all-windows' (ARG negates it)."
  (interactive (list current-prefix-arg))
  (avy-with avy-goto-char
    (avy-jump
     
     (regexp-opt xah-left-brackets)
     :window-flip arg)))

(defhydra hydra-bracket-mov (:color red :hint nil :pre (hs-minor-mode))
  "
              ^By List^             ^By Level^           ^Actions^
              ^^^^^^^^----------------------------------------------
              _i_: next          _e_: higher        _t_: toggle-hs
              _h_: prev          _n_: inner         _m_: mark-sexp
              _f_: end-of        _w_: avy-word
              "
  ("q" nil)
  (";" nil)
  ("i" my/smart-forward-list)
  ("h" backward-list)
  ("e" backward-up-list)
  ("n" down-list)
  ("t" (progn
         (hs-toggle-hiding)
         (backward-up-list)))
  ("s" consult-line)
  ("f" forward-list)
  ("w" avy-goto-word-1 :exit t)
  ("a" avy-goto-open-brackets)
  ("m" mark-sexp))

(defhydra hydra-buff-commands (:color red :post (hydra-move-by/body))
  ("b t" beginning-of-buffer "Buffer Top" :exit t)
  ("b e" end-of-buffer "Buffer End" )
  ("b s" switch-to-buffer "Buffer Switch" )
  ;;("p f" project-find-file "Project FF" :exit nil)
  )


(defhydra hydra-avy ()
  ("q" nil)
  ("i" avy-goto-char "char")
  ("I" consult-imenu "imenu")
  ("n" avy-goto-line "line")
  ("e" my/avy-goto-end-of-line "line end")
  ("v" scroll-up-command "down")
  ("u" scroll-down-command "up")
  ("l" recenter-top-bottom "center")
  ("s" consult-line "search")
  ("m" set-mark-command "mark")
  ("p" project-find-file "proj-file")
  ("." consult-buffer)
  ("b" consult-project-buffer "buffer")
  
  ("x" avy-goto-xah-open "open")
  ("r" anzu-replace-at-cursor-thing "replace")
  ("RET" back-to-avy/body :exit t))


(defhydra back-to-avy (:color pink)
("/" hydra-avy/body :exit t)
("z" nil))

(defhydra hydra-reading-helper (:color pink
                                :base-map (make-sparse-keymap))
  ("<escape>" nil)
  ("SPC" (progn
           (insert " ")
           (keyboard-quit)) "insert space")
  (";" scroll-other-window "scroll"))
