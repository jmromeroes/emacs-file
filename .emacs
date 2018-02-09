(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))

(prefer-coding-system 'utf-8)

(require 'cl-lib)

(load-theme 'misterioso)

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

(add-to-list 'load-path "~/.emacs.d/elpa/neotree/")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;; ace jump mode major function
;; 
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Configuration for expand-region library
(global-set-key (kbd "C-=") 'er/expand-region)

;; Selection will be removed on typing
(delete-selection-mode 1)

;;magit configuration
(global-set-key (kbd "C-x g") 'magit-status)

;;this is useful to go to previous buffer
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;Key chord mode configuration
(add-to-list 'load-path "~/.emacs.d/elpa/key-chord/")
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "SP" 'switch-to-previous-buffer)
(put 'upcase-region 'disabled nil)

;;Rest client configuration
(add-to-list 'load-path "~/.emacs.d/elpa/restclient.el/")
(require 'restclient)

;;Yafolding configuration
(add-to-list 'load-path "~/.emacs.d/elpa/yafolding/")
(require 'yafolding)
(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-S-return>") 'yafolding-hide-parent-element)
    (define-key map (kbd "<C-M-return>") 'yafolding-toggle-all)
    (define-key map (kbd "<C-return>")  'yafolding-toggle-element)
    map))

(add-to-list 'load-path "~/.emacs.d/elpa/json-reformat/")
(add-to-list 'load-path "~/.emacs.d/elpa/json-snatcher/")
(add-to-list 'load-path "~/.emacs.d/elpa/json-mode/")
(require 'json-mode)
