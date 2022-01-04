;;; early-init.el -*- lexical-binding: t -*-

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(setq gc-cons-threshold (* 64 1024 1024))
(let ((gc-cons-threshold-backup gc-cons-threshold)
      (gc-cons-percentage-backup gc-cons-percentage)
      file-name-handler-alist-backup file-name-handler-alist)
  ;; Change garbage collector settings and file-name-handler
  (setq gc-cons-threshold 402653184
        gc-cons-percentage 0.6
        file-name-handler-alist nil)
  ;; Then restore it as late as possible
  (add-hook 'emacs-startup-hook
            (lambda ()
              (message "Restored original settings")
              (setq gc-cons-threshold gc-cons-threshold-backup
                    gc-cons-percentage gc-cons-percentage-backup
                    file-name-handler-alist (append file-name-handler-alist-backup file-name-handler-alist)))))

(display-battery-mode 1)
(display-time-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(global-auto-revert-mode 1)         ; enable auto revert mode globally
;; Set default font
(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 100
                    :weight 'normal
                    :width 'normal)
