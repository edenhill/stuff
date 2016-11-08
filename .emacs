
(require 'iso-transl)

(color-theme-initialize)
(color-theme-robin-hood)
(global-set-key [f5] 'recompile)
(global-set-key [f6] 'compile)
(global-set-key [f1 f1] 'man-follow)
(global-set-key (kbd "§") 'dabbrev-expand)
(global-set-key (kbd "C-n") 'next-error)
(global-set-key (kbd "C-p") 'previous-error)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(setq-default indent-tabs-mode nil)
(show-ws-toggle-show-tabs)
(show-ws-toggle-show-trailing-whitespace)

(next-error-follow-minor-mode)
(which-function-mode)
(column-number-mode)
;; (desktop-save-mode 1)


(add-hook 'before-save-hook #'gofmt-before-save)

(defun my-switch-c-h ()
 (interactive)
 (let* ((name (buffer-file-name)))
   (if (string-match "\\.c$" name)
       (progn
         (setq name (concat (substring name 0 (1- (length name))) "h"))
         (find-file name))
     (if (string-match "\\.h$" name)
         (progn
           (setq name (concat (substring name 0 (1- (length name))) "c"))
           (find-file name))))))

(global-set-key [f4] 'my-switch-c-h)


(add-to-list 'auto-mode-alist '("\\.mc\\'" . c-mode))
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 158 :width normal)))))


(defun toggle-fullscreen-x11 ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(defun my:window-setup-hook ()
  (toggle-fullscreen-x11)
  (when window-system
    (let* ((dconf-entry
            (shell-command-to-string
             "dconf read /com/ubuntu/user-interface/scale-factor"))
           (scale-factor 32)
           ;; text-width make room for gutter and fringes
           (text-width (truncate (/ 80 (/ scale-factor 8.0))))
           (text-height (truncate (/ 50 (/ scale-factor 8.0)))))
      (set-frame-size (selected-frame) text-width text-height))))
(setq window-setup-hook 'my:window-setup-hook)
