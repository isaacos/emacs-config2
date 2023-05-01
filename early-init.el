
(setq gc-cons-threshold (* 50 1000 1000))
(customize-set-variable 'load-prefer-newer t)

(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(recentf-mode 1)

(repeat-mode)

(setq-default isearch-yank-on-move t)
(setq-default set-mark-command-repeat-pop t)

;;elpaca
(setq package-enable-at-startup nil)
;;end

(menu-bar-mode -1)

(setq doc-view-continuous t)


(tab-bar-mode -1)
;; Loads a nice blue theme, avoids the white screen flash on startup.
;; (load-theme 'deeper-blue t)

(setq inhibit-startup-message t)
(setq inhibit-compacting-font-caches t)

(customize-set-variable 'initial-major-mode 'fundamental-mode)
