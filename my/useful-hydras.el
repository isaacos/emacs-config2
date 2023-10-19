(provide 'useful-hydras)

(defvar xah-brackets '("“”" "()" "[]" "{}" "<>" "＜＞" "（）" "［］" "｛｝" "❛❜" "❝❞" "❨❩" "❪❫" "❴❵" "❬❭" "❮❯" "❰❱"))

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

              (defun avy-goto-open-brackets ()
                (interactive)
                (avy-jump (regexp-opt xah-left-brackets)))

              (defhydra hydra-bracket-mov (:color red :hint nil)
                "
              ^By List^             ^By Level^           ^Actions^
              ^^^^^^^^----------------------------------------------
              _i_: next          _e_: higher
              _h_: prev          _n_: inner         _m_: mark-sexp
              _f_: end-of        _w_: avy-word
              "
                ("q" nil)
                (";" nil)
                ("i" my/smart-forward-list)
                ("h" backward-list)
                ("e" backward-up-list)
                ("n" down-list)
                ("f" forward-list)
                ("w" avy-goto-word-1 :exit t)
                ("a" avy-goto-open-brackets)
                ("m" mark-sexp))

(defhydra hydra-diff-hl (:color red)
                "diff hunk"
                ("q" nil)
                ("n" diff-hl-next-hunk)
                ("e" diff-hl-previous-hunk))

              (defhydra hydra-move-by (:color red :exit t)
                "move by"
                ("n" hydra-vi/body "Char")
                ("o" hydra-bracket-mov/body "Bracket")
                ("h" hydra-diff-hl/body "HL diff")
                
                ("p f" project-find-file "Project FF" :exit nil)
                ("b" hydra-buff-commands/body )
                
                )

              (defhydra hydra-buff-commands (:color red :post (hydra-move-by/body))
                ("b t" beginning-of-buffer "Buffer Top" :exit t)
                ("b e" end-of-buffer "Buffer End" )
                ("b s" switch-to-buffer "Buffer Switch" )
                ;;("p f" project-find-file "Project FF" :exit nil)
                )

(defhydra hydra-vi ()
  "vi"
  ("h" backward-char)
  ("n" next-line)
  ("e" previous-line)
  ("i" forward-char)
  ("m" set-mark-command)
("q" nil)
  )

(global-set-key (kbd "C-c m") #'hydra-move-by/body)

(defhydra hydra-flycheck ()
  "flycheck errors"
  ("f" flycheck-next-error)
  ("p" flycheck-previous-error)
("q" nil)
  )
