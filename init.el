;; Define the custom file (so emacs doesnt fill our init file)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


(require 'package)
(add-to-list 'package-archives '("melpa"."https://melpa.org/packages/") t)
(package-initialize)

;; use 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; File format
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)


;; GUI
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Theme
(use-package exotica-theme
	     :config(load-theme 'exotica t))

;; Line numbers
(when(version<="26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; disable word wrap
(set-default 'truncate-lines t)

;; Highlight current line
(global-hl-line-mode 1)

;; Font
(add-to-list 'default-frame-alist '(font . "Fira Code-12" ))
(set-face-attribute 'default t :font "Fira Code-12" )

;; Modeline
;;(use-package all-the-icons
;;  :ensure t)
(use-package doom-modeline
  :ensure t
  :init(doom-modeline-mode 1))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

;; Neotree file browser
(use-package neotree
  :ensure t
  :init
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-theme (if(display-graphic-p) 'icons 'arrow)))


;; Indentation
(setq-default indent-tabs-mode nil) ; Use spaces NOT tabs
(setq tab-width 4)

;; --------------------------
;; ----- LANGUAGE MODES -----
;; --------------------------
;; Z80 Mode - use the .z80 file extension
(load "~/.config/emacs/z80-mode.el")

;; Web Dev
;;(use-package web-mode)
;;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

;; Markdown
;;(use-package markdown-mode
;;  :ensure t
;;  :mode ("\\.md\\'" . markdown-mode)
;;  :init (setq markdown-command "multimarkdown"))


;; Which key
(use-package which-key
  :init
  (which-key-mode t))

;; LSP Mode
(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
                                           projectile hydra flycheck
                                           company avy which-key helm-xref
                                           dap-mode yasnippet-snippets))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; Sample Helm
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1) ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))



;; ---------------------------
;; ----- BACKUP SETTINGS -----
;; ---------------------------
(setq
 backup-by-copying t     ; dont clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))  ; dont litter filesystem
 delete-old-versions t
 kept-new-versions 6
 ketp-old-versions 2
 version-control t)      ; use versioned backups
