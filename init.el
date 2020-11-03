;; Emacs Configuration File
;; Author: Pedro Augusto Santana
;; GitHub: pedro-augusto-santana
;; 2020

;;; Code:
;; Basic Settings
(setq-default frame-title-format '("Emacs")
	      ring-bell-function 'ignore
	      frame-resize-pixelwise t
	      default-directory "~/")
(setq inhibit-startup-screen t) ;; disable splash screen
(setq initial-scratch-message nil) ;; disable scratch message

;; (basic) Useful mode configuration
(delete-selection-mode 	+1) ;; delete in text replacement
(column-number-mode 	+1) ;; show column numbers in statusline
(setq make-backup-files nil) ;; disable backup files
(setq confirm-kill-processes nil
      create-lockfiles	nil
      make-backup-files nil) ;; remove backups and lockfiles
(show-paren-mode 	+1) ;; show matching pairs
(menu-bar-mode 		-1) ;; disable menubar
(tooltip-mode		-1) ;; tooltip
(tool-bar-mode		-1) ;; toolbar
(scroll-bar-mode	-1) ;; scrollbar
(setq-default tab-width 4) ;; tabs are defined as 4 spaces, unless language does not define itself
(setq-default indent-tabs-mode nil) ;; convert tabs to spaces
(savehist-mode 		 1) ;; saves command history between sessions
(tab-bar-mode	   	-1)
(global-hl-line-mode 1) ;; highlight current line

;; better ESC behavior
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key isearch-mode-map [escape] 'isearch-abort)
(define-key isearch-mode-map "\e" 'isearch-abort)

;; (basic) UI changes
(set-face-attribute 'default nil
		    :font "Source Code Pro"
		    :height 135) ;; font configurations

;; disable the annoying line break arrows
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil))
;; set line numbers
(setq display-line-numbers-width 		nil)	;; makes the line number width consistent, pretty anoying on larger files
(global-display-line-numbers-mode 		1)		;; activates line numbers for everything* (see below)

;; disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                treemacs-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

;; packages configuration
(require 'package)
;; plugin sources
(add-to-list 'package-archives '("gnu" 		. 	"https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa"	. 	"https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" 		. 	"https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil) ;; disable startup package

(package-initialize) ;; force package start
;; package-manager (use-package)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(provide 'init)

;; general keybindings
(use-package general
  :ensure t)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

;; default autoclosing
(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

;; evil mode ( Vim keybindings )
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)
  (define-key evil-insert-state-map (kbd "C-SPC") 'company-complete))

;; smooth scrolling
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))

(setq mouse-wheel-scroll-amount '(0.07)
      mouse-wheel-progressive-speed nil)

;; icon themes
(use-package all-the-icons
  :ensure t )

;; theme pack
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-dark+ t)
  ;; (doom-themes-treemacs-config)
  (setq doom-themes-treemacs-enable-variable-pitch nil))

;; doom-modeline ( statusline )
(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 25 )
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-buffer-file-name-style 'truncate-from-project)
  (set-face-attribute 'mode-line nil
                      :font "Source Code Pro"
                      :height 110)
  (set-face-attribute 'mode-line-inactive nil
                      :font "Source Code Pro"
                      :height 110)
  (doom-modeline-mode 1))

;; file explorer
(use-package treemacs-all-the-icons
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-fringe-indicator-mode t)
  (progn
    (setq treemacs-show-cursor nil
          treemacs-width 25))
  (treemacs-filewatch-mode )
  (treemacs-load-theme "all-the-icons")
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
  (define-key treemacs-mode-map (kbd "C-w <right>") 'evil-window-right)
  (add-hook 'treemacs-mode-hook (lambda() (text-scale-decrease 1))))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

;; which-key ( helper-utility )
(use-package which-key
  :ensure t
  :config
  (setq which-key-idle-delay 0.5)
  (setq which-key-idle-secondary-delay 0.5)
  (which-key-mode 1))

;; multiple cursors ( this thing is a GOD SEND )
(use-package evil-multiedit
  :ensure t
  :config
  (define-key evil-visual-state-map (kbd "C-n") 'evil-multiedit-match-and-next)
  (define-key evil-normal-state-map (kbd "C-n") 'evil-multiedit-match-and-next)
  (define-key evil-insert-state-map (kbd "C-n") 'evil-multiedit-match-and-next))

;; ivy / counsel / swipper ( multiple autocompletion utilities )
(use-package ivy
  :ensure t
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel ;; better commands and search functionality
  :hook (ivy-mode . counsel-mode)
  :config
  (global-set-key (kbd "C-S-P" ) 'counsel-M-x)
  (global-set-key (kbd "C-S-F" ) 'counsel-grep-or-swiper)
  (setq counsel-rg-base-command "ag --vimgrep %s"))

(use-package ivy-rich ;; makes ivy more beautiful
  :ensure t
  :init
  (ivy-rich-mode 1)) ;; enables it globally

;; autocompletion popup
(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-require-match nil))


(add-hook 'after-init-hook 'global-company-mode)

;; autocompletion popup style
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons))

  ;; better support for html
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.[x]htm[l]\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js[x]\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ts[x]\\'" . web-mode)))

(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode)
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        '(("TODO"	warning bold)
          ("FIXME"	error bold)
          ("HACK"	font-lock-constant-face bold)
          ("REVIEW"	success bold)
          ("NOTE"	bold)
          ("DEPRECATED"	font-lock-doc-face bold))))

;; commentary
(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

;; linting / syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-popup-tip
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))

;; prettier org lists
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda() (org-bullets-mode 1))))

;; FIXME - ADD LANGUAGE SERVER YOU FUCKING BULLSHIT
;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))

;; TODO
;; add language server protocols (eglot / lsp-mode)
;; later change this to a org file, self documenting (WAY LATER)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages
   '(lsp-mode evil-multiedit web-mode counsel which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
