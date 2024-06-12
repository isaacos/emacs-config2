(provide 'my-rosepine-moon)
(require 'modus-themes)

(setq modus-vivendi-tinted-palette-overrides
      '(
        (cursor "#80e080")

        (keyword red)
        (constant yellow)
        (variable yellow)
        (string cyan)
        (bg-char-0 magenta)
        (bg-char-1 red-warmer)
        (bg-char-2 "#393552");;magenta-warmer)
        (comment "#6e6a86")
        ;; (heading-0 red-cooler)


        (bg-main "#232136")

        (bg-dim "#2a273f")

        (fg-main "#e0def4")

        (fg-dim           "#56526e")
        (fg-alt           "#c6daff")
        (bg-active        "#4a4f69")
        (bg-inactive      "#56526e")
        (border           "#61647a")

;;; Common accent foregrounds

        (red "#eb6f92")
        (red-warmer      "#ca1c4d")
        (red-cooler      "#e96288")
        (red-faint       "#f6bccc")
        ;;unset
        (red-intense     "#ff5f5f")

        (green "#80e080")

        (green-warmer    "#2db82d");; "#70b900")
        (green-cooler     "#70dc70");;"#00c06f")
        (green-faint      "#c2f0c2");;"#88ca9f")

        (green-intense    "#3e8fb0");;"#44df44")

        (yellow          "#f6c177")

        (yellow-warmer   "#fec43f")
        (yellow-cooler   "#dfaf7a")
        (yellow-faint    "#d2b580")
        (yellow-intense  "#efef00")

        (blue            "#3e8fb0")

        (blue-warmer     "#79a8ff")
        (blue-cooler     "#00bcff")
        (blue-faint      "#82b0ec")
        (blue-intense    "#338fff")

        (magenta         "#c4a7e7")

        (magenta-warmer   "#a173d9");;"#f78fe7")
        (magenta-cooler   "#b6a0ff")
        (magenta-faint    "#bc9be4")
        (magenta-intense  "#ff66ff")

        (cyan            "#9ccfd8")

        (cyan-warmer     "#4ae2f0")
        (cyan-cooler     "#6ae4b9")
        (cyan-faint      "#9ac8e0")
        (cyan-intense    "#00eff0")

        )
      )

(setq modus-themes-headings
      '((1 . t)           ; keep the default style
        (2 . (semibold 1.2))
        (t . (rainbow)))) ; style for all other headings

(load-theme 'modus-vivendi-tinted :no-confirm)

  (custom-set-faces
   '(avy-lead-face
     ((t (:foreground "#2a283e" :background "#ff5f5f"))))
   '(vertico-quick1
     ((t (:foreground "#2a283e" :background "#ff5f5f"))))
   '(avy-lead-face-0
     ((t (:foreground "#2a283e" :background "#f6bccc"))))
   '(vertico-quick2
     ((t (:foreground "#2a283e" :background "#f6bccc"))))
   '(avy-lead-face-1
     ((t (:foreground "#2a283e" :background "#338fff"))))
   )
;; (defface avy-lead-face
;;   '((t (:foreground "black" :background "#4f57f9")))
;;   "Face used for first non-terminating leading chars.")

;; (defface avy-lead-face-0
;;   '((t (:foreground "black" :background "#4f57f9")))
;;   "Face used for first non-terminating leading chars.")
