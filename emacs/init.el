(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See package-archive-priorities
;; and package-pinned-packages. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(tool-bar-mode -1)
(menu-bar-mode -1)
(load-theme 'gruvbox t)

;; (global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-hl-line-mode t)
(setq hl-line-overlay-priority -50)
(custom-set-faces
 '(region ((t (:background "#5e81ac")))))

(setq inhibit-startup-screen t)

(show-paren-mode 1)

(setq whitespace-style '(face tabs spaces trailing))
;; (global-whitespace-mode t)
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Remove trailing whitespace on save in prog-mode
(add-hook 'prog-mode-hook
          (lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))


(setq select-enable-clipboard t
      select-enable-primary t)

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)

;; Jump back
(global-set-key (kbd "C-o") 'pop-global-mark)
(setq mark-ring-max 32
      global-mark-ring-max 128)

(defun my/save-position ()
  "Save position before switching buffers/windows."
  (unless (or (minibufferp)
              (string-prefix-p " " (buffer-name)))
    (push-mark (point) t nil)))

(add-hook 'window-buffer-change-functions
          (lambda (_) (my/save-position)))

(super-save-mode +1)
(setq vterm-timer-delay nil)
(require 'company)
(global-company-mode 1)

;; GitHub Copilot configuration
(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :rev :newest
            :branch "main")
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  ;; Set idle delay to reduce interference with company-mode
  (setq copilot-idle-delay 0.1)
  ;; Adjust indentation settings
  (add-to-list 'copilot-indentation-alist '(prog-mode 4))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2)))

;; Optional: Install company-box for better visual integration
;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode))

(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

(setq whitespace-style '(face spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])))
(add-hook 'c-mode-hook 'whitespace-mode)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(scroll-bar-mode -1)
(fido-vertical-mode 1)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((ruby-mode ruby-ts-mode) . ("ruby-lsp"))))
(add-hook 'ruby-mode-hook 'eglot-ensure)

(setq project-kill-buffers-when-switching t)

;; Remapping I-search to Ctrl-f
;; (global-set-key (kbd "C-f") 'isearch-forward)

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :config
  (setq markdown-enable-wiki-links t))

(use-package olivetti
  :ensure t
  :hook (text-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 80))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(set-face-attribute 'default nil
                    :family "CaskaydiaMono Nerd Font"
                    :weight 'light
                    :height 140
                    0)

(global-set-key (kbd "C-s-c C-s-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

;; Custom variables в отдельный файл
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
