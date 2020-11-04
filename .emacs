(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:update-interval 2)
 '(inhibit-startup-screen t)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(pyvenv flymake-python-pyflakes py-autopep8 jedi elpy smartparens neotree ace-jump-mode scala-mode multiple-cursors ebal haskell-mode elm-mode all-the-icons)))
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(prefer-coding-system 'utf-8)

(require 'cl-lib)

;; For MacOS
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;; First you should install all-the-icons package and run "M-x all-the-icons-install-fonts" and download font-lock+.el to ~/emacs.d/lisp
(load "font-lock+")
(require 'font-lock)
(require 'font-lock+)
(use-package all-the-icons)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(add-hook 'emacs-startup-hook
  (lambda ()
    (load-theme 'misterioso)
    ))

(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier 'none)

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;;Multiple cursors configutaion
(global-set-key (kbd "C-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(global-set-key (kbd "C-c I") 'find-user-init-file)

;; Loading and setting Neotree
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(global-set-key [f8] 'neotree-toggle)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Elpy 
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Fixing bug for jump to definition
(defun elpy--xref-backend ()
  "Return the name of the elpy xref backend."
  (if (or (and (not (elpy-rpc--process-buffer-p elpy-rpc--buffer))
               (elpy-rpc--get-rpc-buffer))
          elpy-rpc--jedi-available)
      'elpy
    nil))
(setq elpy-rpc-backend "jedi")

;; Adding path to virtualenv
(setq elpy-rpc-virtualenv-path "~/Documents/deeplearning/machine-learning-platform/mlp_backend/mlp-env/")

;; Disable annoying notifications
(setq ring-bell-function 'ignore)

;; Adding line numbers in the file
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
