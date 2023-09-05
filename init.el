(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-12"))

(require 'package)
(when (version<= "28.0.50" emacs-version )
  (global-display-line-numbers-mode))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")t)
(add-to-list 'package-archives '("org". "https://orgmode.org/elpa/"))
(require 'use-package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")


;; elpaca attempt
;; (defvar elpaca-installer-version 0.5)
;; (defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
;; (defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
;; (defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
;; (defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
;;                               :ref nil
;;                               :files (:defaults (:exclude "extensions"))
;;                               :build (:not elpaca--activate-package)))
;; (let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
;;        (build (expand-file-name "elpaca/" elpaca-builds-directory))
;;        (order (cdr elpaca-order))
;;        (default-directory repo))
;;   (add-to-list 'load-path (if (file-exists-p build) build repo))
;;   (unless (file-exists-p repo)
;;     (make-directory repo t)
;;     (when (< emacs-major-version 28) (require 'subr-x))
;;     (condition-case-unless-debug err
;;         (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
;;                  ((zerop (call-process "git" nil buffer t "clone"
;;                                        (plist-get order :repo) repo)))
;;                  ((zerop (call-process "git" nil buffer t "checkout"
;;                                        (or (plist-get order :ref) "--"))))
;;                  (emacs (concat invocation-directory invocation-name))
;;                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
;;                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
;;                  ((require 'elpaca))
;;                  ((elpaca-generate-autoloads "elpaca" repo)))
;;             (progn (message "%s" (buffer-string)) (kill-buffer buffer))
;;           (error "%s" (with-current-buffer buffer (buffer-string))))
;;       ((error) (warn "%s" err) (delete-directory repo 'recursive))))
;;   (unless (require 'elpaca-autoloads nil t)
;;     (require 'elpaca)
;;     (elpaca-generate-autoloads "elpaca" repo)
;;     (load "./elpaca-autoloads")))
;; (add-hook 'after-init-hook #'elpaca-process-queues)
;; (elpaca `(,@elpaca-order))
;; (elpaca elpaca-use-package
;;   ;; Enable :elpaca use-package keyword.
;;   (elpaca-use-package-mode)
;;   ;; Assume :elpaca t unless otherwise specified.
;;   (setq elpaca-use-package-by-default t))

;; ;; Block until current queue processed.
;; (elpaca-wait)



;; (add-hook 'after-init-hook (lambda ()
;;                             ))


(defun my/load-config ()
  (progn
    (message "started loading config")
    (recentf-mode 1)
    (repeat-mode)

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
     '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
     '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
     '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
     '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
     '(org-level-5 ((t (:inherit outline-5 :height 1.05)))))
;;(global-set-key (kbd "C-t") ctl-x-map)
    ;;(global-set-key (kbd "M-m") #'mark-sexp)
    ;;(org-babel-load-file (expand-file-name "~/.emacs.d/my-meow.org"))
   ;; (org-babel-load-file (expand-file-name "~/.emacs.d/my-evil-config.org"))
   (org-babel-load-file (expand-file-name "~/.emacs.d/elpaca-init.org"))
    ;;(org-babel-load-file (expand-file-name "~/.emacs.d/ryo-modal.el"))

    (message "config was loaded")))

(add-hook 'after-init-hook
  (lambda () (progn
    (setq cursor-type 'hbar)
    
    (use-package nerd-icons
      ;;:elpaca t
      :defer t
      :ensure t)

    (use-package all-the-icons
      ;;:elpaca t
      :defer t
      :ensure t)

    (use-package doom-themes
      ;;:elpaca t
      :ensure t
      :config
      ;; Global settings (defaults)
      (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
            doom-themes-enable-italic t) ; if nil, italics is universally disabled
      (load-theme 'doom-miramare t)

      ;; Enable flashing mode-line on errors
      (doom-themes-visual-bell-config)
      ;; Enable custom neotree theme (all-the-icons must be installed!)
      (doom-themes-neotree-config)
      ;; or for treemacs users
      ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
      (doom-themes-treemacs-config)
      ;; Corrects (and improves) org-mode's native fontification.
      (doom-themes-org-config))

    (use-package doom-modeline
      ;;:elpaca t
      :ensure t
      :config
      (setq doom-modeline-buffer-encoding nil))
    (doom-modeline-mode))))

(run-with-idle-timer 1 nil 'my/load-config)
;; (my/load-config)
(setq org-agenda-files '("~/.emacs.d/agenda/tasks.org"))

(setq org-capture-templates
      '(("t" "Tasks / Projects")
        ("tt" "tasks" entry (file+olp "~/.emacs.d/agenda/tasks.org" "TASKS")
         "* TODO %?\n %U\n %a\n %i" :empty-lines 1)
        ("tr" "reading" entry (file+olp "~/.emacs.d/agenda/tasks.org" "READING")
         "* TODO %?\n %U\n %a\n %i" :empty-lines 1)))
;; END

;;uncomment
;;(org-babel-load-file (expand-file-name "~/.emacs.d/my-init.org"))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(anzu-mode-lighter "")
;;  '(anzu-replace-to-string-separator " => ")
;;  '(custom-safe-themes
;;    '("c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "89d9dc6f4e9a024737fb8840259c5dd0a140fd440f5ed17b596be43a05d62e67" "cd322dc37af17c4e122c99c93fe1a423dd1407797fe51d2278fc25c60a46be45" "2b474647799a29add7e3cf34cd9f8178e872f6a4f354f58f4e717d93a53a4eed" "ddffe74bc4bf2c332c2c3f67f1b8141ee1de8fd6b7be103ade50abb97fe70f0c" "f053f92735d6d238461da8512b9c071a5ce3b9d972501f7a5e6682a90bf29725" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "7ea883b13485f175d3075c72fceab701b5bf76b2076f024da50dff4107d0db25" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "545ab1a535c913c9214fe5b883046f02982c508815612234140240c129682a68" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "2078837f21ac3b0cc84167306fa1058e3199bbd12b6d5b56e3777a4125ff6851" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "ff24d14f5f7d355f47d53fd016565ed128bf3af30eb7ce8cae307ee4fe7f3fd0" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "683b3fe1689da78a4e64d3ddfce90f2c19eb2d8ab1bab1738a63d8263119c3f4" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "ae426fc51c58ade49774264c17e666ea7f681d8cae62570630539be3d06fd964" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "bfc0b9c3de0382e452a878a1fb4726e1302bf9da20e69d6ec1cd1d5d82f61e3d" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "30dc9873c16a0efb187bb3f8687c16aae46b86ddc34881b7cae5273e56b97580" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "2c613514f52fb56d34d00cc074fe6b5f4769b4b7f0cc12d22787808addcef12c" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "df1cbfd16a8af6e821c3299d92c84a0601e961f1be6efd761d6dd40621fde9eb" "d537a9d42c6f5349d1716ae9be9a0645cc168f7aff2a8353819d570e5d02c0b3" "f1b2de4bc88d1120782b0417fe97f97cc9ac7c5798282087d4d1d9290e3193bb" "f28d85b0f3a789923ae8262c85702bc98a481ffc3ef1f0d916a0650bcd71c70e" "474513bacf33a439da7b9a5df1dd11a277929d8480752675fc7d5f3816d8fdef" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "a37d20710ab581792b7c9f8a075fcbb775d4ffa6c8bce9137c84951b1b453016" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "6a2a3687289b4554db053af4d6b1d04f7bfe6c54b911f41e6965ac8bfc2a3964" "34be6a46f3026dbc0eed3ac8ccf60cba5d2a6ad71aa37ccf21fbd6859f9b4d25" "a15bf10d72178d691b09c4bbf6d24b15c156fbae9e6fdbaf9aa5e1d9b4c27ca6" "2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" "57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" "45830f6a1aacf065bee5853f619522773ba635a3f0d52938dbcd967d65496605" "d824f0976625bb3bb38d3f6dd10b017bdb4612f27102545a188deef0d88b0cd9" "fa1b2c364b1d058d0611caa5f5c9b2e8cdd0eca519ef88af2de2a2728bbf8070" "803aaddee599b43da31fb0fd8fae0fa58b4ef7617c673f07201e3463a3099957" "d16a286583f7326bb1e3baf7d83df3643533cfa9ac6f0601d1b4a595ad2db523" "83afe95f30785201eb9e189bf507b0f38076a436804c987c52830214ac025906" "0f08efc35f1190204ac227e8c866b18400612d2137e2d13dcbf4693953681ff3" "e103856e345842bf4334b3db8b773ad01153ce02a3d6655d7c6f5cdb9558c62c" "234c3805fb341b7ce2a9e8ce6d72dba9b81e9335422cfee838e128edfb8a9774" "eb93ba33f178940853271e32f889ad56e5cfece616cc14e776429cb02870bd26" "83f4659ff482028561aed742320eaa491b1416c7c43181647f0c8ef256610dca" "8d371c95370c5965746ccddd94fe96d7a2fbcdd67a77b3951db6fb11f68baf7d" "bd82a9cabe0cb7edd0bd33f696e140ca331af235baab8b268fb2d098b0e366ce" "63865ac3d0f7fe970be87f4690ed3c19be51632808f65e6fdd812e74f98b95fa" default))
;;  '(package-selected-packages
;;    '(binky-mode dirvish embark-consult embark rjsx-mode lsp-mode puni god-mode crux undo-tree ansible doom-themes vterm js2-mode consult-eglot tree-sitter-langs tree-sitter magit easy-kill super-save rg fennel-mode lua-mode prettier pdf-tools hydra key-chord sly org-bullets consult-notes consult browse-kill-ring cape corfu denote projectile ace-window rainbow-delimiters eglot cider clojure-mode marginalia orderless doom-modeline all-the-icons which-key vertico use-package selected avy anzu))
;;  '(warning-suppress-types '((use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "#1f2430" :background "#f28779" :height 3.0))))
 '(easy-kill-origin ((t (:inherit error :background "white smoke" :foreground "red" :inverse-video t))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.05)))))

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)



(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)
(setq gc-cons-threshold (* 2 1000 1000))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(custom-safe-themes
   '("f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "467dc6fdebcf92f4d3e2a2016145ba15841987c71fbe675dcfe34ac47ffb9195" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "545ab1a535c913c9214fe5b883046f02982c508815612234140240c129682a68" default))
 '(package-selected-packages
   '(expreg origami meow dap-mode treesit-auto visual-fill-column nov use-package-chords zop-to-char which-key web-mode vterm vertico use-package undo-tree tree-sitter-langs tide super-save sly selected rjsx-mode rg rainbow-delimiters puni prettier-js prettier pdf-tools org-bullets orderless nerd-icons marginalia magit lua-mode lsp-mode key-chord hydra fennel-mode expand-region embark-consult easy-kill doom-themes doom-modeline dirvish diff-hl denote crux corfu consult-notes consult-eglot cider cape browse-kill-ring anzu ansible annalist all-the-icons ace-window)))
(put 'upcase-region 'disabled nil)


