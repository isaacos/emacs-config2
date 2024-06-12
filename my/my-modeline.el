(provide 'my-modeline)

;; (setq mode-line-format nil)
;; (kill-local-variable 'mode-line-format)
;; (force-mode-line-update)


;; (setq-default mode-line-format
;;       '("%e"
;; " "
;; (:eval (format "%s" meow--indicator))
;; (:eval (format " %s" (buffer-name))
;; ;; (setcar mode-line-position
;; ;;         '(:eval (format "%3d%%" (/ (window-start) 0.01 (point-max)))))
;;        )))


;; (defun my/buffer-modeline-format ()
;;   (let ((file-name (buffer-file-name)))
;;     (let ((buff-name (if file-name
;;                      file-name
;;                    (buffer-name))))
;;          buff-name)))

;; (set-default mode-line-format '("%e" (doom-modeline-format--main)))

(require 'magit)

(setq-default mode-line-format nil)

(kill-local-variable 'mode-line-format)

(force-mode-line-update)

(defface my-modeline-background
  '((t :foreground "white" :inherit bold))
  "Face with a blue background for use on the mode line.")

(defface my-modeline-inactive-background
  '((t :foreground "#ff6c6b" :inherit bold))
  "Face with a blue background for use on the mode line.")


(defface my-modeline-background-green
  '((t :foreground "#2a273f" :background "#80e080" :inherit bold :family "UbuntuMono Nerd Font Mono" :font-size 200))
  "green foreground")

(defface my-modeline-background-red

  '((t :foreground "#2a273f" :background "#eb6f92" :inherit bold :family "UbuntuMono Nerd Font Mono" :font-size 200))
  "red foreground")

(defface my-modeline-background-blue
  '((t :foreground "#2a273f" :background "#51afef" :weight ultra-bold :family "UbuntuMono Nerd Font Mono" :font-size 200))
  "blue foreground")

(defface my-modeline-background-violet
  '((t :foreground "#2a273f" :background "#c4a7e7" :inherit bold :family "UbuntuMono Nerd Font Mono" :font-size 200))
  "violet foreground")


(defface my-modeline-foreground-violet
  '((t :foreground "#c4a7e7"))
  "violet foreground")


(defface my-modeline-foreground-green
  '((t :foreground "#80e080"))
  "green foreground")


(defface my-modeline-background-orange
  '((t :foreground "#2a273f" :background "#ea9a97" :inherit bold :family "UbuntuMono Nerd Font Mono" :font-size 200))
  "orange foreground")


(defface my-modeline-foreground-orange
  '((t :foreground "#ea9a97" :inherit bold))
  "orange foreground")


(defface my-modeline-foreground-yellow
  '((t :foreground "#f6c177" :inherit bold))
  "yellow foreground")

(defun my-modeline--buffer-name ()
  "Return `buffer-name' with spaces around it."
  (format (if (buffer-narrowed-p)
              "%s"
              "%s")
          (buffer-name)))


(defun my-modeline--major-mode ()
  "Return `major-mode' with spaces around it."
  (my-modeline-major-mode-icon))


(defun my-modeline-major-mode-icon ()
  "Return `major-mode' with spaces around it."
  (let ((current-mode (symbol-name major-mode)))
    (cond
     ((equal current-mode "emacs-lisp-mode") (propertize "" 'face 'my-modeline-foreground-violet))

     ((equal current-mode "js-ts-mode") (propertize "󰐅" 'face 'my-modeline-foreground-yellow))

     ((equal current-mode "typescript-mode") (propertize "󰛦" 'face 'my-modeline-foreground-yellow))
     ((equal current-mode "org-mode") (propertize "" 'face 'my-modeline-foreground-green))
     (t current-mode))))

(defun my-modeline--evil-modes ()
  "Return `evil-mode-icons'"
  (when (bound-and-true-p evil-local-mode)
    (cond
     ((evil-normal-state-p) (propertize " 󰫻 " 'face 'my-modeline-background-green))
     ((evil-emacs-state-p) (propertize " 󰫲 " 'face 'my-modeline-background-violet))
     ((evil-insert-state-p) (propertize " i " 'face 'my-modeline-background-blue))
     ((evil-motion-state-p) (propertize " 󰫺 " 'face 'my-modeline-background-orange))
     ((evil-visual-state-p) (propertize " 󰬃 " 'face 'my-modeline-background-red))
     ((evil-operator-state-p) (propertize " 󰫼 " 'face 'my-modeline-background-orange))
     ((evil-replace-state-p) (propertize " 󰫿 " 'face 'my-modeline-background-orange))
     (t "evil mode"))))

;; (my-modeline--evil-modes)

;; (my-modeline--buffer-name)

(defvar-local my-modeline-buffer-name
    '(:eval
      (if (or (mode-line-window-selected-p) (not (buffer-file-name)))
          (propertize (my-modeline--buffer-name) 'face 'my-modeline-background)
        (propertize (my-modeline--buffer-name) 'face 'my-modeline-inactive-background)))
  "Mode line construct to display the buffer name.")


(defvar-local my-modeline-evil-mode
    '(:eval
      (when (mode-line-window-selected-p)
        (my-modeline--evil-modes)))
  "Mode line construct to display the buffer name.")

(defvar-local my-modeline-major-mode
    '(:eval
      (when (mode-line-window-selected-p)
         (my-modeline--major-mode)))
  "Mode line construct to display the buffer name.")

(defvar-local my-modeline-modified
    '(:eval
      (when (and (buffer-modified-p) (buffer-file-name))
        (propertize " 󰳻" 'face 'my-modeline-foreground-orange)))
  "Modified buffer")

(defvar-local my-modeline-macro-recording
    '(:eval
      (when (or defining-kbd-macro)
        (propertize " " 'face 'my-modeline-background-orange)))
  "Modified buffer")

(defun my/get-git-branch ()
  "Return the current Git branch. From ChatGPT"
  (when (magit-toplevel)
    (magit-get-current-branch)))


(defvar-local my-modeline-git-branch
   '(:eval
      (if (my/get-git-branch)
          (propertize (concat " " (my/get-git-branch) " ") 'face 'my-modeline-foreground-yellow)
      ""))
  "Mode line construct to display the buffer name.")

(put 'my-modeline-git-branch 'risky-local-variable t)
(put 'my-modeline-buffer-name 'risky-local-variable t)
(put 'my-modeline-evil-mode 'risky-local-variable t)
(put 'my-modeline-modified 'risky-local-variable t)
(put 'my-modeline-macro-recording 'risky-local-variable t)

(put 'my-modeline-major-mode 'risky-local-variable t)

;; write a function to do the spacing
;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format "%%s %%%ds" available-width) left right)))

(setq-default mode-line-format
              '((:eval (simple-mode-line-render
                        ;; left
                        (format-mode-line '("%e"
                                            my-modeline-evil-mode
                                            my-modeline-macro-recording
                                            my-modeline-modified
                                            " "
                                            my-modeline-git-branch
                                            my-modeline-buffer-name
                                            " "
                                            mode-line-percent-position))
                ;; right
                        (format-mode-line '("%e"
                                            my-modeline-major-mode
                                            " "
                                            "%M"
                                            ))))))


(mode-line-window-selected-p)
