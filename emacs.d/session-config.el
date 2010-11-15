;; session (http://emacs-session.sf.net)
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;(autoload 'session "~/.emacs.d/session.el" "This saves 
;          certain variables like input histories." t)

;; desktop.el
(load "desktop")
(desktop-save-mode 1)

;; Save minibuffer history between sessions
(require 'save-history)

(require 'recentf)
(setq recentf-auto-cleanup 'never) ;;To protect tramp
(recentf-mode 1)
