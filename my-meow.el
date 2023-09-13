;; (defun ctrl-prefix (char)
;;   (interactive "c" )
;;   (execute-kbd-macro (kbd (concat "C-" (string char)))))

  (defun meow-setup ()
    ;;(setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak)
    (meow-motion-overwrite-define-key
     ;; Use e to move up, n to move down.
     ;; Since special modes usually use n to move down, we only overwrite e here.
     '("e" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     '("?" . meow-cheatsheet)
     ;; To execute the originally e in MOTION state, use SPC e.
     ;; '("e" . "H-e")
     '("E" . "H-e")
     ;; '("e" . ctrl-prefix)

     '("bb" .  switch-to-buffer)
     '("B" .  consult-buffer)
     '("bi" .  ibuffer)
     '("bs" .  crux-sudo-edit)
     '("bc" .  crux-cleanup-buffer-or-region)
     '("bk" .  kill-buffer)
     '("bt" .  kill-this-buffer)
     '("bm" .  switch-to-minibuffer)

     '("g s" . magit-status)

     '("p" . "C-x p") ;;project prefix map

     '("r" . "C-x r") ;; mostly functions involving the register
     '("SPC" .  execute-extended-command)
     '("," . embark-act)

     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("1" . meow-expand-1)
     '("2" . meow-expand-2)
     '("3" . meow-expand-3)
     '("4" . meow-expand-4)
     '("5" . meow-expand-5)
     '("6" . meow-expand-6)
     '("7" . meow-expand-7)
     '("8" . meow-expand-8)
     '("9" . meow-expand-9)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("<" . puni-barf-forward)
     '(">" . puni-slurp-forward)
     '("/" . meow-visit)
     '("a" . meow-append)
     '("A" . meow-open-above)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("C" . meow-end-or-call-kmacro)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)

     '("e" . meow-prev)
     '("E" . meow-prev-expand)
     ;;'("f" . meow-find)
     '("f" . meow-next-word)
     '("F" . meow-next-symbol)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-right)
     '("I" . meow-right-expand)
     '("j" . meow-join)
     '("k" . meow-kill)
     '("K" . kmacro-toggle-start-end)
     '("l" . meow-line)
     '("L". meow-goto-line)
     '("m" . meow-mark-word)
     '("M" . meow-mark-symbol)
     '("n" . meow-next)
     '("N" . meow-next-expand)
     '("o" . meow-to-block)
     '("O" . meow-block)
     ;;'("y" . meow-yank)
     '("p" . meow-find)
     '("q" . meow-quit)
     '("r" . meow-replace)
     ;; '("R" . anzu-query-replace-at-cursor)
     '("s" . meow-insert)
     '("S" . meow-open-below)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-search)
     '("w" . meow-save)
     ;;'("W" . meow-next-symbol)
     ;; '("x" . meow-delete)
     '("x t" . meow-transpose-sexp)
     ;; '("X" . meow-backward-delete)
     '("x e" . meow-beginning-of-thing)
     '("x n" . meow-end-of-thing)
     '("x r" . anzu-query-replace-at-cursor)
     '("x s" . isearch-forward)
     '("x m" . meow-mark-symbol)
     '("x k" . kmacro-toggle-start-end)
     '("x i" . meow-open-below)
     '("x o" . crux-smart-open-line)
     '("x c" . "<f4>")
     '("x SPC" . pop-to-mark-command)

     '("y" . meow-yank)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))

  (use-package meow
    :init
    (meow-global-mode 1)
    :config
    (global-set-key (kbd "C-x r C-.") #'point-to-register)

    (setq meow-cursor-type-insert 'box)
    (setq meow-keypad-start-keys '((?i . ?c) ;;breaks naming convention but frees c in leader
                                   ;; (?h . ?h) ;;removed inorder to rebind h to C-M-
                                   (?t . ?x))) ;; easier to access than x
    (setq meow-origami-keymap (make-keymap))
    (meow-define-state origami
      "meow state for interacting with smartparens"
      :lighter " [O]"
      :keymap meow-origami-keymap)
(setq meow-keypad-ctrl-meta-prefix ?h)
    ;; meow-define-state creates the variable
    (setq meow-cursor-type-origami 'hollow)
    (setq meow-cursor-type-beacon '(box))

    (add-hook 'meow-insert-mode-hook (lambda () (set-cursor-color "#87af87")))
    (add-hook 'meow-normal-mode-hook (lambda () (set-cursor-color "white")))

    (meow-define-keys 'origami
      '("<escape>" . meow-normal-mode)
      '("n" . origami-next-fold)
      '("e" . origami-previous-fold)
      '("t" . origami-toggle-node)
      '("o a" . origami-open-all-nodes)
      '("c a" . origami-close-all-nodes)
      '("SPC" . meow-keypad)
      '("u" . meow-undo))
    (setq meow-use-clipboard t)
    (setq meow-replace-state-name-list
          '((normal . "<N>")
            (motion . "<M>")
            (keypad . "<K>")
            (insert . "<E>")
            (beacon . "<B>")
            (origami . "<O>")))
  (meow-setup)

    ;;fixed meow-end-kmacro to allow it to be called via keypad
    (defun meow-end-kmacro ()
      "End kmacro recording or call macro.

      This command is a replacement for built-in `kmacro-end-macro'."
      (interactive)
      (cond
       ((or (meow-normal-mode-p)
            (meow-motion-mode-p))
        (call-interactively #'kmacro-end-or-call-macro))
       )))

