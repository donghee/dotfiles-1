;;; load elisp
(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/X") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/bbdb") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/prog-modes") load-path))
(autoload 'lyskom "lyskom" "LysKOM" t)

(tool-bar-mode nil)

;;; xcscope
(require 'xcscope)

(if (eq window-system 'x)
 (progn
  (load "faces")
  (setq hilit-mode-enable-list '())
  (require 'paren)
  (require 'faces)

  (set-default-font "Monaco Malgun Gothic-14")
  (add-to-list 'default-frame-alist '(font
                                    . "Monaco Malgun Gothic-14"))
  
  (make-face 'mykeyword-face)
  (set-face-foreground 'mykeyword-face "#6959ce")
  (setq font-lock-keyword-face 'mykeyword-face )

  (defvar paren-face 'paren-face)
  (make-face 'paren-face)
  (set-face-foreground 'paren-face "#88aaff")

  (defvar brace-face 'brace-face)
  (make-face 'brace-face)
  (set-face-foreground 'brace-face "#ffaa88")

  (defvar bracket-face 'bracket-face)
  (make-face 'bracket-face)
  (set-face-foreground 'bracket-face "#aaaa00")


  (add-hook 'scheme-mode-hook
            '(lambda ()
               (setq scheme-font-lock-keywords-2
                     (append '(("(\\|)" . paren-face))
                             '(("{\\|}" . brace-face))
                             scheme-font-lock-keywords-2))))

  (add-hook 'c-mode-hook
            '(lambda ()
               (setq c-font-lock-keywords-3
                    (append '(("(\\|)" . paren-face))
                            '(("{\\|}" . brace-face))
                            '(("\\[\\|\\]" . bracket-face))
                            c-font-lock-keywords-3))))

  (add-hook 'sml-mode-hook
            '(lambda ()
               (setq sml-font-lock-keywords
                     (append '(("(\\|)" . paren-face))
                             '(("\\[\\|\\]" . bracket-face))
                             sml-font-lock-keywords))))

  (add-hook 'python-mode-hook
            '(lambda ()
               (setq python-font-lock-keywords
                     (append '(("(\\|)" . paren-face))
                             '(("\\[\\|\\]" . bracket-face))
                             python-font-lock-keywords))))

))

;;; standard display ascii
;(standard-display-ascii ?\225 [?+])

(progn
(standard-display-ascii ?\200 (vector (decode-char 'ucs #x000d)))
(standard-display-ascii ?\201 (vector (decode-char 'ucs #x251c)))
(standard-display-ascii ?\202 (vector (decode-char 'ucs #x252c)))
(standard-display-ascii ?\203 (vector (decode-char 'ucs #x250c)))
(standard-display-ascii ?\203 (vector (decode-char 'ucs #x000d)))
(standard-display-ascii ?\204 (vector (decode-char 'ucs #x2524)))
(standard-display-ascii ?\205 (vector (decode-char 'ucs #x2502)))
(standard-display-ascii ?\206 (vector (decode-char 'ucs #x2510)))
(standard-display-ascii ?\210 (vector (decode-char 'ucs #x2534)))
(standard-display-ascii ?\211 (vector (decode-char 'ucs #x2514)))
(standard-display-ascii ?\212 (vector (decode-char 'ucs #x2500)))
(standard-display-ascii ?\214 (vector (decode-char 'ucs #x2518))))

(progn
(standard-display-ascii ?\200 [15]) (standard-display-ascii ?\201 [21])
(standard-display-ascii ?\202 [24]) (standard-display-ascii ?\203 [13])
(standard-display-ascii ?\204 [22]) (standard-display-ascii ?\205 [25])
(standard-display-ascii ?\206 [12]) (standard-display-ascii ?\210 [23])
(standard-display-ascii ?\211 [14]) (standard-display-ascii ?\212 [18])
(standard-display-ascii ?\214 [11]))

;; no splash screen
(setq inhibit-startup-message t)

;; display dirs first in dired
(setq ls-lisp-dirs-first t) 

;; conventional selection/deletion
(delete-selection-mode t)

(require 'bs)

;;; Tramp settings
(require 'tramp)
;(add-to-list 'Info-default-directory-list
;  "~/.emacs.d/tramp/info/")
(setq tramp-default-method "sshx")

(setq tramp-debug-buffer t)
(setq tramp-verbose 10)

(tramp-set-completion-function "sshx"
               '((tramp-parse-sconfig "/etc/ssh_config")
                 (tramp-parse-sconfig "~/.ssh/config")))


;;; Eshell settings
(require 'em-term)
(setq
 eshell-rc-script "~/.eshellrc"
 eshell-modules-list  '(eshell-alias 
			eshell-basic 
			eshell-cmpl
			eshell-dirs
			eshell-glob
			eshell-hist
			eshell-ls
			eshell-pred
			eshell-prompt 
			eshell-rebind
			eshell-smart
			eshell-term
			eshell-unix
			eshell-xtra))

(add-to-list 'eshell-visual-commands "elias")
(add-to-list 'eshell-visual-commands "jed")
(add-to-list 'eshell-visual-commands "psql")


;; shell¸ðµå¿¡¼­ ansi»ö º¸ÀÌ±â À§ÇÑ ¼³Á¤
(add-hook 'comint-output-filter-functions
                  'comint-strip-ctrl-m)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)



;; Set uthe terminal
(add-hook 'term-mode-hook
	  (function
	   (lambda ()
	     (set-face-foreground 'term-default-bg-inv "white")
	     (set-face-background 'term-default-bg-inv "gray60")
	     (set-face-foreground 'term-bold "orange")
	     (set-face-underline-p 'term-underline nil)
	     (set-face-foreground 'term-underline "lightslategrey")
	     (set-face-bold-p 'term-underline t)
	     (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *\\|^[<]*[>]")
	     (make-local-variable 'mouse-yank-at-point)
	     (make-local-variable 'transient-mark-mode)

	     (setq transient-mark-mode nil)
	     (auto-fill-mode -1)
	     (setq tab-width 8 )
;; 	     (setq mode-line-format '((:eval (getenv "USER")) "@" 
;; 				      (:eval (getenv "HOSTNAME")) 
;; 				      ":" (:eval default-directory) ))
	     (define-key term-raw-map [?\M-x] 'execute-extended-command))))
     


;; Ask to quit emacs
;(setq kill-emacs-query-functions
;      (cons (lambda () (yes-or-no-p "Really kill Emacs? "))
;            kill-emacs-query-functions))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-input-method "korean-hangul")
 '(display-time-mode t)
 '(ecb-compilation-buffer-names (quote (("*Kill Ring*") ("*Calculator*") ("*vc*") ("*vc-diff*") ("*Apropos*") ("*Backtrace*") ("*Help*") ("*shell*") ("*eshell*") ("*bsh*") ("*Messages*") ("*compilation*") ("*grep*"))))
 '(ecb-compile-window-enlarge-by-select t)
 '(ecb-compile-window-height 5)
 '(ecb-compile-window-temporally-enlarge (quote both))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-enlarged-compilation-window-max-height (quote best))
 '(ecb-eshell-auto-activate nil)
 '(ecb-layout-name "left13")
 '(ecb-layout-nr 9)
 '(ecb-non-semantic-parsing-function nil)
 '(ecb-options-version "2.32")
 '(ecb-other-window-behavior (quote edit-and-compile))
 '(ecb-other-window-jump-behavior (quote edit-and-compile))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-select-edit-window-on-redraw t)
 '(ecb-source-path (quote ("~/work/webpy/webbs" "~/work" "~")))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote image))
 '(ecb-tree-image-icons-directories (quote ("/usr/share/emacs/site-lisp/ecb/ecb-images/default/height-17" (ecb-directories-buffer-name . "/usr/share/emacs/site-lisp/ecb/ecb-images/directories/height-17") (ecb-sources-buffer-name . "/usr/share/emacs/site-lisp/ecb/ecb-images/sources/height-14_to_21") (ecb-methods-buffer-name . "/usr/share/emacs/site-lisp/ecb/ecb-images/methods/height-14_to_21"))))
 '(ecb-wget-setup (cons "wget" (quote cygwin)))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep -n -e ")
 '(help-char 26)
 '(help-event-list (quote (help f1)))
 '(ido-decorations (quote ("{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]")))
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-tramp-completion t)
 '(ido-enabled (quote (quote both)) t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-show-dot-for-dired t)
 '(ido-use-filename-at-point (quote guess))
 '(indent-tabs-mode nil)
 '(iswitchb-case t)
 '(iswitchb-default-method (quote samewindow))
 '(iswitchb-define-mode-map-hook (quote (llasram/iswitchb-extra-keys)))
 '(iswitchb-mode nil nil (iswitchb))
 '(jde-jdk-doc-url "file:///usr/share/doc/j2sdk1.4.1/html/api/")
 '(jde-run-java-vm-w "java")
 '(kill-whole-line t)
 '(nxml-slash-auto-complete-flag t)
; '(org-agenda-files (quote ("/home/dak/doc/org/QuestionLog.org" "/home/dak/doc/org/agendas.org" "/home/dak/doc/org/elephantshrew.org" "/home/dak/doc/org/essay.org" "/home/dak/doc/org/gtd.org" "/home/dak/doc/org/icte20091008.org" "/home/dak/doc/org/idea.org" "/home/dak/doc/org/incserver.org" "/home/dak/doc/org/index.org" "/home/dak/doc/org/itgiftedproduct.org" "/home/dak/doc/org/kentbecklog.org" "/home/dak/doc/org/kodoc_coffee.org" "/home/dak/doc/org/ktidea20090824.org" "/home/dak/doc/org/livecoding.org" "/home/dak/doc/org/lysp200908.org" "/home/dak/doc/org/mitmedialab_200908.org" "/home/dak/doc/org/morningpage.org" "/home/dak/doc/org/netlogo20090812.org" "/home/dak/doc/org/p.art.y.org" "/home/dak/doc/org/piksel2007.org" "/home/dak/doc/org/piny20091005.org" "/home/dak/doc/org/popstory.org" "/home/dak/doc/org/processing.org" "/home/dak/doc/org/reading.org" "/home/dak/doc/org/realedu_20090930.org" "/home/dak/doc/org/researchlog.org" "/home/dak/doc/org/robot_p2.org" "/home/dak/doc/org/robot_paper_summary.org" "/home/dak/doc/org/sangsang_200909.org" "/home/dak/doc/org/sditgifted_netlogo.org" "/home/dak/doc/org/sicp.org" "/home/dak/doc/org/squeakclass.org" "/home/dak/doc/org/squeaklog.org" "/home/dak/doc/org/timelog.org" "/home/dak/doc/org/writinglog.org")))
 '(safe-local-variable-values (quote ((Coding . iso-2022-7bit))))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t)
 '(user-mail-addre;; M-x html-regex-replace <rexp> string: replace matches to regex 'rexp'
;; with 'string' but only in text, not in mark-up tags
(defun html-regex-replace (re to &optional arg)
  (interactive (query-replace-read-args "Replace regexp" t))
  (let (lim)
    (while (not (eobp))
    (setq lim (save-excursion
                (skip-chars-forward "^<")
                (point-marker)))
    (while (re-search-forward re lim t)
      (replace-match to))
    (goto-char lim)
ss "dongheepark@gmail.com"))

    (or (eobp) (forward-char 1)))))


;; pop-up buffer
;;(defun danl-pop-up-buffer (arg)
;  "Toggle popup of buffer NAME."
;  (interactive)
;  (if (string= (buffer-name) arg)
;      (delete-window)
;    (progn 
;      (pop-to-buffer arg t))))

;(danl-global-set-key [f3] '(danl-pop-up-buffer "*zenirc*<2>"))
;(danl-global-set-key [f4] '(danl-pop-up-buffer "*zenirc*"))
	


;;; Pretty minibuffer
;(load "pretty-minibuffer")
;(pretty-minibuffer-mode 1 )



;;; Temporary

(put 'erase-buffer 'disabled nil)

;;; java Mode
;; auto-complition c-c-v-.

(c-add-style
 "java"
 '((c-basic-offset . 4)
   (c-comment-only-line-offset 0 . 0)
   (c-hanging-comment-starter-p)
   (c-offsets-alist
    (topmost-intro-cont . +)
    (statement-block-intro . +)
    (substatement-open . 0)
    (substatement . +)
    (inline-open . 0)
    (label . 0)
    (statement-case-open . +)
    (statement-cont . +)
    (knr-argdecl-intro . 5)
    (arglist-intro . +)
    (arglist-close . c-lineup-arglist)
    (brace-list-entry . 0)
    (access-label . 0)
    (inher-cont . c-lineup-java-inher)
    (func-decl-cont . c-lineup-java-throws))))

(add-hook 'java-mode-hook
	  (function (lambda ()
		      (c-set-style "java"))))

 

;;  invoke mozilla-firefox
(setq browse-url-browser-function 'browse-url-firefox)

;(setq browse-url-browser-function 'browse-url-firefox-new-tab)


;(defun browse-url-firefox-new-tab (url &optional new-window)
;  "Open URL in a new tab in Firefox."
;  (interactive (browse-url-interactive-arg "URL: "))
;  (message "Starting Firefox...")
;  (start-process (concat "firefox \"" url "\"") nil "/bin/sh" "-c"
;                 (concat "mozilla-firefox \"" url "\" || true"))
;  (message "Starting Firefox...done"))

;;; gauche

(defun gauche ()
  (interactive)
  (run-scheme "gosh -i"))

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (let ((sw (selected-window)))
    (save-excursion
      (switch-to-buffer-other-window
       (get-buffer-create "*scheme*"))
      (gauche)
      (select-window sw))))


;;; Python mode
;; pymacs

(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

;; bike man
(pymacs-load "bikeemacs" "brm-")
;(brm-init)

(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.jy$" . jpython-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))

(defun danl-py-map ()
  (interactive)
  (define-key py-mode-map [M-tab]  'dabbrev-expand)
;  (define-key py-mode-map "\C-x\C-e"  'danl-py-execute-line)
  (define-key py-mode-map "\M-s"  'py-shell))
;  (define-key py-mode-map [f5] 'py-execute-buffer)
;  (danl-global-set-key [f5] 'py-execute-buffer)

(add-hook 'python-mode-hook 
    (function 
        (lambda ()
	  (auto-fill-mode -1)
	  (define-key py-mode-map [f4] 'py-shell)
	  (define-key py-mode-map [f5] 'py-execute-buffer))))

;(defun danl-py-execute-line ()
;  (interactive)
;  (py-execute-region (point-at-bol) (point-at-eol)))
    
(add-hook 'python-mode-hook  'danl-py-map)

;  (define-key py-mode-map "\C-c\C-r"  'py-shift-region-right)


;(define-key global-map "\e!" 'shell-command-with-completion)

;;; New Python-mode commands:
(defun py-execute-line ()
  "Executes the current line of Python code."
  (interactive)
;  (let ((sw (selected-window)))
  (py-execute-region (line-beginning-position)
                     (line-end-position))
;  (other-window -1)
;  (select-window sw)
;  )
)

(defun py-execute-block (&optional extend)
  "Executes the following block of Python code.
See `py-mark-block' for usage of prefix argument."
  (interactive "P")
  (py-mark-block extend)
  (py-execute-region (point) (mark))
;  (other-window -1)
)

(add-hook 'python-mode-hook
  (lambda ()
    (define-key py-mode-map "\C-c\C-j" 'py-execute-line)
    (define-key py-mode-map "\C-c\C-e" 'py-execute-block)))

;;for unittest
;(setq special-display-buffer-names 
;      '("*Python*" "*Python Output*" "*compilation*" "JPython"))

;(setq special-display-buffer-names 
;      '("*Python*" "*Python Output*" "JPython"))

(add-hook 'python-mode-hook 
  (lambda ()
    (define-key py-mode-map [f6] 'py-unittest)))

(defun py-unittest ()
"run unittest on file in the current buffer "
    (interactive)
    (compile
     (format "python \"%s\""
        (buffer-file-name))))

(defun runtests () (interactive)
    (compile "python /somepath/Twisted/admin/runtests"))

;(global-set-key [f6] 'py-unittest)

;; jython
(setq py-default-interpreter 'jpython)
(setq py-jpython-command "jython")

(add-hook 
'python-mode-hook 
(lambda ()
  (let ((using-jython
        (save-excursion 
        (goto-char (point-min))
                   (looking-at "#!.*\(java\|jp?ython\)"))))
    (py-toggle-shells (if using-jython 'jpython 'cpython)))))
;http://www.geocrawler.com/mail/msg.php3?msg_id=7639693&list=7017
;
;
;;; ipython
;;(setq ipython-command "/usr/bin/ipython")
;;(require 'ipython)


;;; pycomplete (M-C-i)
(require 'pycomplete)

;;; python flymake
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
    
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))


;; (defun py-execute-region (around my-py-execute-region)
;;   "back to the original buffer when py-execute-region finished."
;;   (if (get-buffer "*Python Output*")
;; 	  (kill-buffer "*Python Output*") 
;; 	nil)
;;   ad-do-it
;;   (shrink-window-if-larger-than-buffer)
;;   (other-window -1)
;; )

;; add pylookup to your loadpath
(add-to-list 'load-path "~/.emacs.d/pylookup")

;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file "~/.emacs.d/pylookup/pylookup.db")

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

;; ropemacs
(pymacs-load "ropemacs" "rope-")

;;; MagicPoint mode
(setq auto-mode-alist
      (cons '("\\.mgp?\\'" . mgp-mode) 
	    auto-mode-alist))
(autoload 'mgp-mode "mgp-mode")
(setq mgp-options ""
      mgp-window-height 6)

;;; SML Mode
(setq load-path (cons "/usr/share/emacs/site-lisp/sml-mode" load-path))
(load "sml-mode-startup")
(setq sml-program-name "sml")
(autoload 'sml-mode "sml-mode" "Major mode for editing SML." t)
(setq auto-mode-alist
      (append '(("\\.sml$" . sml-mode)
                ("\\.sig$" . sml-mode)
                ("\\.ML$"  . sml-mode)) auto-mode-alist))

(add-hook 'sml-mode-hook
  (lambda ()
    (define-key sml-mode-map "\C-c\C-e" 'sml-send-function)))

;;; Haskell hugs interaction  Mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)

(defun mimenuhugs ()
  (define-key haskell-mode-map [menu-bar hugs]
    (cons "Hugs" (make-sparse-keymap "Hugs")))
  (define-key haskell-mode-map
    [menu-bar hugs hugs-reload-file]
    '("Recompilar archivo" . haskell-hugs-reload-file))
  (define-key haskell-mode-map
    [menu-bar hugs hugs-load-file]
    '("Compilar archivo" . haskell-hugs-load-file))
  )  
		   
(add-hook 'haskell-decl-scan-hook 'mimenuhugs)
;http://www.haskell.org/hawiki/HaskellMode

;;; for io language
(require 'io-mode)

;; for mode-compile
;(autoload 'mode-compile "mode-compile"
;  "Command to compile current buffer file dependently of the major mode" t)
;(global-set-key "\C-c\C-c" 'mode-compile)
;(autoload 'mode-compile-kill "mode-compile"
;  "Command to kill a compilation launched by `mode-compile'" t)
;(global-set-key "\C-c\C-k" 'mode-compile-kill)
;
;(defconst cc-default-compiler
;  "gcc"
;  "*Default C compiler to use when everything else fails")
;
;(defvar cc-default-compiler-options
;  "-g -O2 "
;  "*Default options to give to the C compiler")
;
;(setq mode-compile-always-save-buffer-p t)
;(setq mode-compile-save-all-p t)
;(setq compilation-window-height 30)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(highline-face ((t nil)))
 '(show-paren-match ((((class color)) (:background "#9dfa9d")))))

;;; TeX Mode
;(defun do-dvipdfm ()
;     "DVIPDFM the curent file."
;     (interactive)
;     (TeX-command "dvipdfm" 'TeX-master-file))
;
;(global-set-key [(control f5)] 'do-dvipdfm)   ; DVIPDFM the current file

;;; c# mode
(autoload 'csharp-mode "csharp-mode" 
  "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '( "\\.cs\\'" . csharp-mode ) auto-mode-alist ))

;;; Helpers for building regexps.
(defmacro c-paren-re (re)
 `(concat "\\(" ,re "\\)"))
  (defmacro c-identifier-re (re)
 `(concat "\\[^_]"))

;;; j-mode
;;;

(autoload 'j-mode "j-mode.el"  "Major mode for J." t)
(autoload 'j-shell "j-mode.el" "Run J from emacs." t)
(setq auto-mode-alist
            (cons '("\\.ij[rstp]" . j-mode) auto-mode-alist))
;; Set j-path
(setq j-path "/home/dak/prog/j602")
(setq j-command "~/prog/j602/bin/jee")
(setq j-command-args '("~/prog/j602/bin/jwd"))

;; imenu lets you jump between definition
;(add-hook 'j-mode-hook
; (which-func-mode 1) )

;; Author: Patrick Gundlach 
;; nice mark - shows mark as a highlighted 'cursor' so user 'always' 
;; sees where the mark is. Especially nice for killing a region.

(defvar pg-mark-overlay nil
  "Overlay to show the position where the mark is") 
(make-variable-buffer-local 'pg-mark-overlay)

(put 'pg-mark-mark 'face 'secondary-selection)

(defvar pg-mark-old-position nil
  "The position the mark was at. To be able to compare with the
current position")

(defun pg-show-mark () 
  "Display an overlay where the mark is at. Should be hooked into 
activate-mark-hook" 
  (unless pg-mark-overlay 
    (setq pg-mark-overlay (make-overlay 0 0))
    (overlay-put pg-mark-overlay 'category 'pg-mark-mark))
  (let ((here (mark t)))
    (when here
      (move-overlay pg-mark-overlay here (1+ here)))))

(defadvice  exchange-point-and-mark (after pg-mark-exchange-point-and-mark)
  "Show visual marker"
  (pg-show-mark))

(ad-activate 'exchange-point-and-mark)
;(add-hook 'activate-mark-hook 'pg-show-mark)

;;__________________________________________________________________________
;;;;    VM - Mail

;; Some file locations are relative to my HOME or BIN directories
;(defvar home-dir)
;(setq home-dir (concat (expand-file-name "~") "/"))
;(defvar bin-dir (concat home-dir "bin/"))

;; Basic VM setup
;(push (concat bin-dir "emacs/site-lisp/vm") load-path)
;(autoload 'vm "vm" "Start VM on your primary inbox." t)
;(autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
;(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
;(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
;(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
;(autoload 'vm-mail "vm" "Send a mail message using VM." t)
;(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)
;(setq vm-toolbar-pixmap-directory (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/pixmaps"))
;(setq vm-image-directory (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/pixmaps"))
;(setenv "PATH" (concat (concat (expand-file-name "~") "/bin/emacs/site-lisp/vm/bin") ":" (getenv "PATH")))
;(setq send-mail-function 'sendmail-send-it)
;(setq user-full-name "Donghee Park")
;(setq user-mail-address "dongheepark@gmail.com")
;(setq mail-archive-file-name "~/Mail/SENT")

;; Configure inbound mail (POP)
;(setq vm-spool-files
;      '(("~/INBOX" "pop-ssl:pop.gmail.com:995:pass:dongheepark:*" "~/INBOX.CRASH")))

;; Use W3M to read HTML email
;(require 'w3m-load)
;(setq vm-mime-use-w3-for-text/html nil)
;;(setq vm-url-browser 'w3m)
;(load "vm-w3m")
;(setq w3m-input-coding-system 'utf-8
;      w3m-output-coding-system 'utf-8)

;; Configure outbound mail (SMTP)
;(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;      smtpmail-smtp-server "smtp.gmail.com"
;      smtpmail-default-smtp-server "smtp.gmail.com"
;      send-mail-function 'smtpmail-send-it
;      message-send-mail-function 'smtpmail-send-it
;      smtpmail-smtp-service 587
;      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "dongheepark" nil)))
;



;; moz-mode http://dev.hyperstruct.net/mozlab/wiki/MozRepl
(require 'moz)
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode 'moz-minor-setup)

(defun moz-minor-setup ()
  (moz-minor-mode 1))

;; recommanded by moz-mode
(require 'pabbrev)

(add-hook 'javascript-mode 'pabbrev-mode)

;; snippet.el addrev
;;
(require 'snippet)

(add-hook 'nxml-mode-hook
           '(lambda ()
		(setq-default abbrev-mode t) ;; abbrev-mode on
		(snippet-with-abbrev-table 'local-abbrev-table 
	  ("htdiv3" . "<div class=\"section\">\n$>$><h3>$${title}</h3>\n$><p>$${body}</p>\n$.</div>$>")
	  ("htdiv4" . "<div class=\"section\">\n$>$><h4>$${title}</h4>\n$><p>$${body}</p>\n$.</div>$>")
	  ("htdivr" . "<div class=\"section refer\">\n$><ul class=\"source\">\n$>$><li><cite><a href=\"$${cite}\">$${title}</a></cite> ??</li>\n</ul>$>\n$><blockquote cite=\"$${cite}\" title=\"$${title}\">\n$><p>$${body}</p>\n</blockquote>$>\n</div>$>")
    ("hthref" .  "<a href=\"$${url}\">$${title}</a>") ;;
	  )
))

;; pov-mode
(let ((package-dir (concat "~/"
                           ".emacs.d")))
  (when (file-directory-p package-dir)
        (setq load-path (cons package-dir load-path))))

;;; Set autoloading of POV-mode for these file-types.
(autoload 'pov-mode "pov-mode.el" "PoVray scene file mode" t)
(setq auto-mode-alist
      (append '(("\\.pov$" . pov-mode)
                ("\\.inc$" . pov-mode)
                ) auto-mode-alist))

;;; Check flavor. Important for Debian!! -- SU Yong
(setq font-pov-is-Emacs
      (string-match "^emacs" (symbol-name debian-emacs-flavor)))

;;; FIXME:
;;; Since pov-mode has bad scheme for emacsen version check, I have to
;;; make pov-mode to presume that the flavor is emacs21!
(if font-pov-is-Emacs
    (setq font-pov-is-Emacs21 t))

;;; semantic ide
(global-set-key [C-return] 'semantic-complete-analyze-inline)

;;; supercollider3 
;(require 'sclang)

;;; org mode

;(setq load-path (cons (expand-file-name "~/.emacs.d/org-mode") load-path))
(add-to-list 'load-path "~/.emacs.d/org-mode")
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/babel")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
(add-to-list 'load-path "~/.emacs.d/org-s5")

(require 'org-s5)
(require 'org-install)
(require 'org-latex)
(require 'org-html)

;(require 'org-babel-init) 
;(require 'org-babel-R) 

;(add-to-list 'load-path "~/.emacs.d/elpa/inf-ruby-2.1")
; (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
; (autoload 'inf-ruby-keys "inf-ruby" "" t)
; (eval-after-load 'ruby-mode
;   '(add-hook 'ruby-mode-hook 'inf-ruby-keys))

;(require 'org-babel-ruby)      ;; requires ruby, irb, ruby-mode, and
;(require 'org-babel-python)    ;; requires python, and python-mode
;(org-babel-load-library-of-babel)

;(setq log-done t)

(setq org-directory (concat "/home/dak/" "doc/org/")
      org-mobile-directory (concat org-directory "staging/")
      org-mobile-inbox-for-pull (concat org-directory "inbox-pull.org"))

;; (setq org-directory "~/doc/org/"
;;       org-mobile-directory (concat org-directory "staging/")
;;       org-mobile-inbox-for-pull (concat org-directory "inbox-pull.org"))

(defadvice org-mobile-pull (before org-mobile-download activate)
  (shell-command "~/bin/org-download.sh")
  (revert-buffer t t t)
  )

(defadvice org-mobile-push (after org-mobile-upload activate)
(message "Start uploading")
(shell-command "~/bin/org-upload.sh")
(delete-other-windows)
(message "Uploaded org files to picnic server")

 )

(setq org-drawers (quote ("PROPERTIES" "SETUP")))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq inhibit-redisplay nil)

(setq org-agenda-todo-ignore-scheduled t
      org-agenda-tags-todo-honor-ignore-options t
      org-agenda-todo-list-sublevels nil)

      (setq org-global-properties '(("NAME" "This is the value")))

(setq org-agenda-files (list "~/doc/org/backlog.org"
                               "~/doc/org/timelog.org"))

;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-export-latex-classes
  '("takahashi" 
"\\documentclass{beamer}

\\usetheme[pageofpages=of,% String used between the current page and the
                         % total page count.
          bullet=circle,% Use circles instead of squares for bullets.
          titleline=true,% Show a line below the frame title.
          alternativetitlepage=true,% Use the fancy title page.
          titlepagelogo=logo-polito,% Logo for the first page.
%          watermark=watermark-polito,% Watermark used in every page.
          watermark=ksad-logo,% Watermark used in every page.
          watermarkheight=14pt,% Height of the watermark.
          watermarkheightmult=4,% The watermark image is 4 times bigger
                                % than watermarkheight.
          ]{Torino}

\\usepackage{setspace}
\\usepackage{kotex}
\\usepackage{graphicx}
\\usepackage{hyperref}

\\usepackage{takahashi}
\\hypersetup{pdfpagemode=FullScreen} 
\\usepackage{ifxetex} 
\\newcommand{\\stack}[1]{\\begin{tabular}{@{}c@{}}#1\\end{tabular}}
\\ifxetex 
\\usepackage{fontspec}
\\defaultfontfeatures{Mapping=tex-text} 
\\setromanfont [Ligatures={Common}, BoldFont={Fontin Bold}, ItalicFont={Fontin Italic}, Scale=1.2]{Fontin}
\\setsansfont [Ligatures={Common}, BoldFont={Fontin Sans Bold},ItalicFont={Fontin Sans Italic}, Scale=1.3]{Fontin Sans}
\\setsansfont[Scale=1.3]{SeoulHangang}
\\setmonofont[Scale=0.8]{Monaco}
\\setbeamertemplate{navigation symbols}{}  % optionally hide naviation buttons 
\\setbeamerfont{frametitle}{size=\\LARGE}

\\fi

\\newcommand{\\presentationzenwithtext}[2]{
  \\setbeamertemplate{background canvas}{\\includegraphics[width=\\paperwidth, height=\\paperheight, keepaspectratio]{#1}}
  \\takahashi{\\stack{#2}}
  \\setbeamertemplate{background canvas}{}
}

\\newenvironment{changemargin}[2]{%
\\begin{list}{}{%
\\setlength{\\topsep}{0pt}%
\\setlength{\\leftmargin}{#1}%
\\setlength{\\rightmargin}{#2}%
\\setlength{\\listparindent}{\\parindent}%
\\setlength{\\itemindent}{\\parindent}%
\\setlength{\\parsep}{\\parskip}%
}%
\\item[]}{\\end{list}}

\\newcommand{\\maxframe}[1]{
\\begin{frame}[plain]
\\begin{changemargin}{-1cm}{-1cm}
\\begin{center}
#1
\\end{center}
\\end{changemargin}
\\end{frame}
}

\\newcommand{\\presentationzen}[1]{
\\maxframe{
\\includegraphics[width=\\paperwidth,height=\\paperheight,keepaspectratio]
{#1}}
}


\\DeclareGraphicsExtensions{.jpg,.png,.pdf} 
\\DeclareGraphicsRule{.pdf}{eps}{.bb}{}
\\DeclareGraphicsRule{.png}{eps}{.bb}{}
\\DeclareGraphicsRule{.jpg}{eps}{.bb}{}
"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))
 

;; org export latex save-hook
(defun org-export-latex-upload ()
  (let (fname )
    (setq fname (file-name-nondirectory buffer-file-name))
    (setq orgfname  (concat (file-name-sans-extension fname) ".org"))
    (message "Start uploading")
    (shell-command (format "~/bin/org-upload-min.sh %s %s" fname orgfname))
;    (delete-other-windows)
    (message (concat "Uploaded" orgfname " to picnic server"))
))

;;; org-upload-min.sh
;;files=$@
;;cadaver http://picnic.piny.cc/org <<EOF
;;mput $files
;;EOF

(add-hook 'org-export-latex-after-save-hook 'org-export-latex-upload)
;; add to org-export-html-after-save-hook to org-html.el
;;(defvar org-export-html-after-save-hook nil
;;  "Hook run in the finalized Html buffer, after it has been saved.")
;;  ...
;;     (or to-buffer (save-buffer))
;;        (run-hooks 'org-export-html-after-save-hook)
;; ...

(add-hook 'org-export-html-final-hook 'org-export-latex-upload)
;(add-hook 'org-export-html-after-save-hook 'org-export-latex-upload)


;     ("\\takahashi{%s}" . "\\takahashi{\\stack{%s}}")
     ;; ("\\frame{%s}" . "\\frame*{%s}")
     ;; ("\\section{%s}" . "\\section*{%s}")
     ;; ("\\subsection{%s}" . "\\subsection*{%s}")
     ;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ;; ("\\paragraph{%s}" . "\\paragraph*{%s}")))




;; (setq org-directory "~/doc/org/"
;;       org-default-notes-file (concat org-directory "backlog.org")
;;       org-attach-method 'mv)

;; (setq org-agenda-directory (concat "~" "/doc/org/"))
;; (setq org-agenda-files 
;;       (directory-files (expand-file-name org-agenda-directory) t "^.*\\.org$"))

;(put 'downcase-region 'disabled nil)

;(setq org-export-html-style "<link rel=stylesheet href=\"../e/freeshell2.css\" type=\"text/css\">")

;(setq org-export-html-style "<link rel=stylesheet href=\"propella.css\" type=\"text/css\">")

;(setq org-publishing-directory "~/public_html/")

;; (setq org-publish-project-alist
;;           '(("org"
;;              :base-directory "~/doc/org/"
;;              :publishing-directory "~/public_html"
;;              :section-numbers nil
;;              :table-of-contents nil
;;              :style "<link rel=stylesheet
;;                     href=\"propella.css\"
;;                     type=\"text/css\">")))


;; (setq org-publish-project-alist
;;            '(("orgfiles"
;;                :base-directory "~/doc/org/"
;;                :base-extension "org"
;; ;               :publishing-directory "/ssh:user@host:~/html/notebook/"
;;                :publishing-function org-publish-org-to-html
;;                :exclude "PrivatePage.org"   ;; regexp
;;                :headline-levels 3
;;                :section-numbers nil
;;                :table-of-contents nil
;;                :style "<link rel=stylesheet
;;                        href=\"../other/mystyle.css\" type=\"text/css\">"
;;                :auto-preamble t
;;                :auto-postamble nil)
     
;;               ("images"
;;                :base-directory "~/images/"
;;                :base-extension "jpg\\|gif\\|png"
;; ;               :publishing-directory "/ssh:user@host:~/html/images/"
;;                :publishing-function org-publish-attachment)
     
;;               ("other"
;;                :base-directory "~/other/"
;;                :base-extension "css\\|el"
;; ;               :publishing-directory "/ssh:user@host:~/html/other/"
;;                :publishing-function org-publish-attachment)
;;               ("website" :components ("orgfiles" "images" "other"))))


;; org export latex save-hook

(defun org-export-latex-upload ()
(message "Start uploading")
(shell-command  "~/bin/org-upload-min.sh")
(delete-other-windows)
(message "Uploaded org files to picnic server")
)

(add-hook 'org-export-latex-after-save-hook 'org-export-latex-upload)
;; add to org-export-html-after-save-hook to org-html.el
;;(defvar org-export-html-after-save-hook nil
;;  "Hook run in the finalized Html buffer, after it has been saved.")
;;  ...
;;     (or to-buffer (save-buffer))
;;        (run-hooks 'org-export-html-after-save-hook)
;; ...

(add-hook 'org-export-html-after-save-hook 'org-export-latex-upload)


;;; find-recursive
(require 'find-recursive) 

;; text translation 
(add-to-list 'load-path "~/.emacs.d/text-translator-0.6.6")
(require 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator)
; C-u C-x M-t google.com_jaen


;; twitter
;(add-to-list 'load-path "~/.emacs.d/twitter")
;(require 'twitter)

;;changelog
(defun change-log-timestamp ()
(interactive)
(call-process "date" nil t nil "+%Y-%m-%d %H:%M %z: dak")
)

;;mark down
(defun markdown-custom ()
  "markdown-mode-hook"
  (setq markdown-command "markdown | smartypants"))
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))


(defun autospacing (s e) 
  (interactive "r")
 (goto-char e)
 (insert "\n")
 (call-process "/home/dak/bin/autospacing" nil t nil (buffer-substring s e))
 (insert "\n")
)

;; latex
(setq tex-command "latex")
(setq dvi2-command "xdvi -paper a4")

; using wmctrl
(defun full-screen-toggle ()
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))


;; mail
;; wanderlust
(require 'starttls)
(require 'ssl)

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; ;; IMAP
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "dongheepark@gmail.com") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t) 

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "dongheepark")
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

(setq wl-folder-check-async t) 

(setq elmo-imap4-use-modified-utf7 t)

;; (autoload 'wl-user-agent-compose "wl-draft" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'wl-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'wl-user-agent
;;       'wl-user-agent-compose
;;       'wl-draft-send
;;       'wl-draft-kill
;;       'mail-send-hook))

;; wl
(setq ssl-certificate-verification-policy 1)

(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "dongheepark@gmail.com")
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port 993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t)
(setq ssl-program-arguments '("s_client" "-quiet" "-host" host "-port" service))
(setq ssl-certificate-directory "/home/dak/.w3/certs")
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "dongheepark")
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq starttls-negotiation-by-kill-program t)
;(setq starttls-kill-program "C:/cygwin/bin/kill")
(setq wl-local-domain "gmail.com")


(setq wl-folder-check-async t) 

(defun wl-summary-overview-entity-compare-by-reply-date (a b)
  "Compare entity X and Y by latest date of replies."
  (flet ((string-max2
          (x y)
          (cond ((string< x y) y)
                ('t x)))
         (elmo-entity-to-number
          (x)
          (elt (cdr x) 0))
         (thread-number-get-date
          (x)
          (timezone-make-date-sortable (elmo-msgdb-overview-entity-get-date (elmo-message-entity wl-summary-buffer-elmo-folder x))))
         (thread-get-family
          (x)
          (cons x (wl-thread-entity-get-descendant (wl-thread-get-entity x))))
         (max-reply-date
          (x)
          (cond ((eq 'nil x)
                 'nil)
                ((eq 'nil (cdr x))
                 (thread-number-get-date (car x)))
                ('t
                 (string-max2 (thread-number-get-date (car x))
                              (max-reply-date (cdr x)))))))
    (string<
     (max-reply-date (thread-get-family (elmo-entity-to-number a)))
     (max-reply-date (thread-get-family (elmo-entity-to-number b))))))


;(add-to-list 'wl-summary-sort-specs 'reply-date)

;;;------------------------------------------
;; summary-mode ですべての header を一旦除去
(setq mime-view-ignored-field-list '("^.*"))

;; 表示するヘッダ。
;; (setq wl-message-visible-field-list
;;       (append mime-view-visible-field-list
;;         '("^Subject:" "^From:" "^To:" "^Cc:" 
;;           "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
;;           "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:"
;;           )))

;; 隠すメールヘッダを指定。
(setq wl-message-ignored-field-list
      (append mime-view-ignored-field-list
      '(".*Received:" ".*Path:" ".*Id:" "^References:"
        "^Replied:" "^Errors-To:"
        "^Lines:" "^Sender:" ".*Host:" "^Xref:"
        "^Content-Type:" "^Content-Transfer-Encoding:"
        "^Precedence:"
        "^Status:" "^X-VM-.*:"
        "^X-Info:" "^X-PGP" "^X-Face-Version:"
        "^X-UIDL:" "^X-Dispatcher:"
        "^MIME-Version:" "^X-ML" "^Message-I.:"
        "^Delivered-To:" "^Mailing-List:"
        "^ML-Name:" "^Reply-To:" "Date:"
        "^X-Loop" "^X-List-Help:"
        "^X-Trace:" "^X-Complaints-To:"
        "^Received-SPF:" "^Message-ID:"
        "^MIME-Version:" "^Content-Transfer-Encoding:"
        "^Authentication-Results:"
        "^X-Priority:" "^X-MSMail-Priority:"
        "^X-Mailer:" "^X-MimeOLE:"
        )))

(setq elmo-message-fetch-threshold 500000)
;; プリフェッチ時に確認を求めるメールサイズの最大値(デフォルト：30K)
(setq wl-prefetch-threshold 500000)


;;;------------------------------------------
;;; その他の設定
;; デフォルトのフォルダ
(setq wl-default-folder "%inbox")
;; フォルダ名補完時に使用するデフォルトのスペック
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAPの仕様に合わせて
(setq wl-trash-folder "%[Gmail]/Trash")


;;git
(setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'git)
(autoload 'git-blame-mode "git-blame"
            "Minor mode for incremental blame for Git." t)


;; emacsclient from http://be.tech.coop/blog/071001.html
(server-start)
(add-hook 'after-init-hook 'server-start)
(add-hook 'server-done-hook
   (lambda ()
         (shell-command
                  "screen -r -X select `cat ~/.emacsclient-caller`")))

;; (defun org-mobile-push ()
;;   "Push the current state of Org affairs to the WebDAV directory.
;; This will create the index file, copy all agenda files there, and also
;; create all custom agenda views, for upload to the mobile phone."
;;   (interactive)
;;   (let ((a-buffer (get-buffer org-agenda-buffer-name)))
;;     (let ((org-agenda-buffer-name "*SUMO*")
;;           (org-agenda-filter org-agenda-filter)
;;           (org-agenda-redo-command org-agenda-redo-command))
;;       (save-excursion
;;         (save-window-excursion
;;           (org-mobile-check-setup)
;;           (org-mobile-prepare-file-lists)
;;           (run-hooks 'org-mobile-pre-push-hook)
;;           (message "Creating agendas...")
;; ;          (let ((inhibit-redisplay t)) (org-mobile-create-sumo-agenda))
;;           (message "Creating agendas...done")
;;           (org-save-all-org-buffers) ; to save any IDs created by this process
;;           (message "Copying files...")
;;           (org-mobile-copy-agenda-files)
;;           (message "Writing index file...")
;;           (org-mobile-create-index-file)
;;           (message "Writing checksums...")
;;           (org-mobile-write-checksums)
;;           (run-hooks 'org-mobile-post-push-hook))))
;;     (redraw-display)
;;     (when (and a-buffer (buffer-live-p a-buffer))
;;       (if (not (get-buffer-window a-buffer))
;;           (kill-buffer a-buffer)
;;         (let ((cw (selected-window)))
;;           (select-window (get-buffer-window a-buffer))
          
;;           (org-agenda-redo)
;;           (select-window cw)))))
;;   (message "Files for mobile viewer staged"))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; register jumping
;; C-x r j e or b 
(set-register ?e '(file . "~/.emacs"))
(set-register ?b '(file . "~/doc/org/backlog.org"))

