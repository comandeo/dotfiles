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
(fido-mode 1)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((ruby-mode ruby-ts-mode) . ("ruby-lsp"))))
(add-hook 'ruby-mode-hook 'eglot-ensure)

(setq project-kill-buffers-when-switching t)

;; Remapping I-search to Ctrl-f
(global-set-key (kbd "C-f") 'isearch-forward)

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

;; Custom variables в отдельный файл
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
