;;; j-mode
(autoload 'j-mode "j-mode.el"  "Major mode for J." t)
(autoload 'j-shell "j-mode.el" "Run J from emacs." t)
(setq auto-mode-alist
      (cons '("\\.ij[rstp]" . j-mode) auto-mode-alist))

(setq j-path "C:/work/j602/bin/")
(setq j-command "C:/work/j602/bin/jconsole.exe")

(require 'cl)
(when (ignore-errors (require 'which-func))
   (which-func-mode 1)) ; shows the current function in statusbar

;;; quack
(setq quack-pltcollect-dirs '("C:/work/PLT/collects/"))
(setq quack-default-program "c:/work/plt/mzscheme.exe")
(require 'quack)


;; action script 3
(load-file "~/.emacs.d/actionscript-mode.el")
(autoload 'actionscript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.as\\'" . actionscript-mode))

(load-file "~/.emacs.d/fcsh-mode.el")
(setq fcsh-executable "c:/work/flexsdk3.4/bin/fcsh")


; Compilaton Output settings
(setq compile-auto-highlight t
      compilation-scroll-output t)


;; nxml-mode
;;(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.html$" . nxml-mode) auto-mode-alist))
(fset 'html-mode 'nxml-mode)
; (fset 'html-helper-mode 'nxml-mode)

(add-hook 'nxml-mode-hook
          (function (lambda ()
	  (auto-fill-mode -1)
                  )))


(defun nxml-beginning-of-element ()
    "Jump to point after start-tag."
      (interactive)
        (nxml-backward-up-element)
          (forward-sexp)
          )
(global-set-key [?\C-c (home)] 'nxml-beginning-of-element)

(defun nxml-end-of-element ()
    "Jump to point before end-tag."
      (interactive)
        (nxml-up-element)
          (backward-sexp)
          )
(global-set-key [?\C-c (end)] 'nxml-end-of-element)

(defun nxml-kill-to-eoelement ()
  "Kill to end of element. "
  (interactive)
  (let ((start (point)))
    (nxml-end-of-element)
    (Kill-region start (point))))


;;;Lisp slime mode
;(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "/usr/bin/sbcl")
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (set (make-local-variable 'lisp-indent-function)
		 'common-lisp-indent-function)))

(setq slime-net-coding-system 'utf-8-unix)

;;; for utf-8 coding system for slime
;;; (set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;;;Stk scheme mode

(setq scheme-program-name "stk-simply")
(show-paren-mode 1)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t) ; add
(add-hook 'text-mode-hook 
      '(lambda () (auto-fill-mode 1)))

(load "cmuscheme")

(defun run-stk () "
   Remove the *scheme* buffer unless it is running Stk.  If there is no
   *scheme* buffer running Stk, create one.  Switch to the *scheme* buffer."
   (interactive)
   (set-buffer (get-buffer-create "*scheme*"))
   (let ((proc (get-buffer-process "*scheme*")))
     (if (and proc (not (string-match 
			 "stk$" (car (process-command proc)))))
	 (progn 
	   (set-process-buffer proc nil)
	   (kill-process proc))))
   (run-scheme "stk"))

(defun run-half-scheme () "
   Run Scheme in half a window."
   (interactive)
   (split-window-vertically nil)
   (other-window 1)
   (call-interactively 'run-scheme))


;; Additional local key and menu definitions in Scheme mode.

;; (Define-key scheme-mode-map [menu-bar scheme]
;;  (cons "Scheme" (make-sparse-keymap "Scheme")))

(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-load-file-and-go] '("Send Scheme File & Go" . scheme-load-file-and-go))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-load-file] '("Send Scheme File" . scheme-load-file))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-send-region-and-go] '("Send Region & Go". scheme-send-region-and-go))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-send-region] '("Send Region" . scheme-send-region))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-send-defn-and-go]
  '("Send Definition & Go" . scheme-send-definition-and-go))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-send-defn] '("Send Definition" . scheme-send-definition))
(define-key (lookup-key scheme-mode-map [menu-bar scheme])
  [scheme-indent-sexp] '("Indent S-expression" . scheme-indent-sexp))
(setq menu-bar-final-items (cons 'scheme menu-bar-final-items))


(define-key scheme-mode-map "\C-c\M-l" 'scheme-load-file-and-go)
(define-key scheme-mode-map "\r" 'newline-and-indent)

(defun scheme-load-file-and-go (file-name)
  "Load Scheme file FILE-NAME into the inferior Scheme process and then 
go to Scheme buffer."
  (interactive (comint-get-source "Load Scheme file: " scheme-prev-l/c-dir/file
				  scheme-source-modes t)) ; T because LOAD 
                                                          ; needs an exact name
  (scheme-load-file file-name)
  (switch-to-scheme t))

(add-hook 'scheme-mode-hook
	  (function
	   (lambda ()
	     (setq comment-start ";; "))))

(defun scheme-send-enclosing-definition () "
  Send the definition containing point to the *scheme* process."
  (interactive)
  (forward-char 7)
  (search-backward-regexp "^(define")
  (forward-sexp)
  (scheme-send-last-sexp)
  (if (not (null (search-forward "(define" nil t)))
    (backward-char 7)))

(global-set-key "\M-p"          'scheme-send-enclosing-definition)
(global-set-key "\M-s"          'run-half-scheme)
(define-key esc-map "\C-q"	'scheme-indent-sexp)

;; if you use special syntax, you can tell it what you want indented

(put 'sequence 'scheme-indent-function 0)
(put 'define-method 'scheme-indent-function 1)
(put 'slot-ref 'scheme-indent-function 0)


; This function overrides the function of the same name in 
; cmuscheme.el. -- brg, Aug 30 1998
;
(defun switch-to-scheme (eob-p)
  "Switch to the scheme process buffer.
   With argument, positions cursor at end of buffer."
  (interactive "P")
  (if (get-buffer scheme-buffer)
      (switch-to-buffer-other-window scheme-buffer)))


;;; markdown
(defun markdown-custom ()
  "markdown-mode-hook"
  (setq markdown-command "markdown | smartypants"))
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))
