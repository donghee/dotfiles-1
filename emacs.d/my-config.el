;; ;; tab key setting. this is important to me
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)

(setq tool-bar-mode nil)
(setq menu-bar-mode t)

(setq swbuff-y-mode t)

;; turn off bell
(setq visible-bell t) 

;; auto revert-mode
(global-auto-revert-mode t) 

; save buffer with out query
(setq buffer-save-without-query t)

;;-- speedbar option : sync with edit window --
(setq speedbar-mode-hook '(lambda ()
    (interactive)
    (other-frame 0)))

;; no truncate-line
(setq-default truncate-lines t)

;; change yes to y
(fset 'yes-or-no-p 'y-or-n-p)

(require 'recentf)
(setq recentf-auto-cleanup 'never) ;;To protect tramp
(recentf-mode t)

(delete-selection-mode t)

;; ido 
(require 'ido)
(ido-mode t)

(add-hook 'ido-setup-hook 'ido-extra-keys)

(defun ido-extra-keys ()
 "Add my keybindings for ido."
 (define-key ido-completion-map "\C-h" 'ido-delete-backward-updir)
 (define-key ido-completion-map "\C-n" 'ido-next-match)
 (define-key ido-completion-map "\C-f" 'ido-next-match)
 (define-key ido-completion-map "\C-p" 'ido-prev-match)
 (define-key ido-completion-map "\C-b" 'ido-prev-match)
 (define-key ido-completion-map " "    'ido-exit-minibuffer))


;;; yasnippet 
(add-to-list 'load-path "~/.emacs.d/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
;(yas/load-directory "~/.emacs.d/yasnippet-0.6.1c/snippets")

;;; twitter.el
(autoload 'twitter-get-friends-timeline "twitter" nil t)
(autoload 'twitter-status-edit "twitter" nil t)
(global-set-key "\C-xt" 'twitter-get-friends-timeline)
(add-hook 'twitter-status-edit-mode-hook 'longlines-mode)


;;; text translation
(add-to-list 'load-path "~/.emacs.d/text-translator-0.6.6")
(require 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator)
; C-u C-x M-t google.com_jaen

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete)
(require 'auto-complete-config)
(set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols))
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

;; CSS autocomplete inifinite loop hacks
(add-to-list 'ac-css-value-classes
	     '(border-width "thin" "medium" "thick" "inherit"))

(require 'auto-complete-etags)
;(require 'auto-complete-python)

;;  (require 'auto-complete-yasnippet)
;;(global-auto-complete-mode t)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;; moin moin wiki
(require 'moinmoin-mode)

;; test-case mode
(autoload 'test-case-mode "test-case-mode" nil t)
(autoload 'enable-test-case-mode-if-test "test-case-mode")
(autoload 'test-case-find-all-tests "test-case-mode" nil t)
(autoload 'test-case-compilation-finish-run-all "test-case-mode")

;; To enable it automatically when opening test files:
(add-hook 'find-file-hook 'enable-test-case-mode-if-test)
(add-hook 'compilation-finish-functions 'test-case-compilation-finish-run-all)

;; If you want to run all visited tests after a compilation, add:
;(add-hook 'compilation-finish-functions
;;          'test-case-compilation-finish-run-all)

;;; anything-config
(add-to-list 'load-path "~/.emacs.d/anything-config/")

(require 'anything-config)

(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-file-name-history
            anything-c-source-info-pages
            anything-c-source-man-pages
            anything-c-source-file-cache
            anything-c-source-emacs-commands))

(global-set-key (kbd "M-X") 'anything)


;;; find-tag
;; jump to definition
(defun find-tag-noconfirm ()
  (interactive)
  (find-tag (find-tag-default)))
;; TODO: if no tags are found, try and run ctags -Rn in the source root

(define-key global-map  [f3] 'find-tag-noconfirm)
(define-key global-map  [f4] 'pop-tag-mark)

(fset 'find-next-tag "\C-u\256")        ; macro for C-u M-.
(fset 'find-prev-tag "\C-u-\256")       ; macro for C-u - M-.
(define-key global-map "\M-]" 'find-next-tag)
(define-key global-map "\M-[" 'find-prev-tag)


(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)

;; txt2tags
;(add-to-list 'load-path "~/.emacs.d/")
(setq auto-mode-alist (append (list
    '("\\.t2t$" . t2t-mode)
    )
    (if (boundp 'auto-mode-alist) auto-mode-alist)
))

(autoload  't2t-mode "txt2tags-mode" "Txt2tags Mode" t)

(add-hook 't2t-mode-hook
   (lambda ()
     (setq buffer-save-without-query t)
     (define-key t2t-mode-map [f5] 'recompile)
   )
)

(defun txt2html ()
  (interactive)

  (setq fname (file-name-nondirectory buffer-file-name))
  (setq htmlfname  (concat (file-name-sans-extension fname) ".xhtml"))

  (setq bname (concat "python ../txt2tags -t xhtml --toc --encoding=utf-8 "  (buffer-name)))
  (shell-command bname)
  (w32-shell-execute-open-file htmlfname)
;  (w32shell-explorer-current-file)
)

(global-set-key [(C c)(t)(t)] 'txt2html) 

;; line highlighting
(require 'highline)
;(highline-mode-on)

;; abbrev-mode
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs")
(define-key esc-map  " " 'expand-abbrev) ;; M-SPC

;; dabbrev-expand highlighting
(require 'dabbrev-highlight)
;; Bind hippie-expand
(global-set-key "\M- " (make-hippie-expand-function
                               '(try-expand-dabbrev-visible
                                 try-expand-dabbrev
                                 try-expand-dabbrev-all-buffers) t))


(require 'screen-lines)
(screen-lines-mode)
(setq turn-on-screen-lines-mode t)

;; Frame setup
(setq frame-title-format "Emacs: %b")
  (setq default-frame-alist
        (append default-frame-alist '((vertical-scroll-bars
				       . right))))


(defun run-half-eshell () "
   Run eshell in half a window."
   (interactive)
   (split-window-vertically nil)
   (other-window 1)
   (call-interactively 'eshell))

;;; Set my email address 
(setq mail-default-reply-to "dongheepark@gmail.com"
      user-mail-address "dongheepark@gmail.com"
      mail-host-address "gmail.com"
      user-full-name "Dong-Hee Park"
      message-user-organization "Donghee STUDIO")
;(setq  message-default-headers (concat
;		 "X-Face: $z6G{rTuG?OLsBU;ehk7{uPNqBQ@U#i<)czx)J}TUbz+Z`FR3adwU5p[t<1o1:?oLC5vl`i(9vI|r=6p9dh5CT(zvj1Mo/.r\"@S+3CBBoy.cw]Zr'&-S<.-KBv5yLn.@wSun6D\"(jZ1S@PWq1-#2dDZc\\MS,GB{s`Bu6sN\n"
;			 ))

;;; Dates and calendar
(setq europan-calendar-style t
      calendar-week-start-day 1)


;; Search with highlight
(setq-default search-highlight t)
(copy-face 'highlight 'isearch)

;; Filling
(global-set-key [S-f3] 'fill-region)
(global-set-key [S-f4] 'auto-fill-mode)
(setq-default auto-fill-function 'do-auto-fill)

;; Info setup
(setq Info-default-directory-list 
      (cons "/usr/share/emacs/info/"
	      Info-default-directory-list))

;; Modeline
(setq display-time-24hr-format t
      display-time-display-time-foreground "white"
      display-time-mail-file nil)
(display-time)
(line-number-mode t)
(column-number-mode t)

;; SGML
(setq sgml-set-face t
      sgml-default-doctype-name nil)

;; Paren mode
(show-paren-mode)
(setq show-paren-style 'parenthesis)

;;; kill-summary
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map "\ey" 'kill-summary)

(define-key minibuffer-local-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-map "\C-n" 'next-history-element)
(define-key minibuffer-local-ns-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-ns-map "\C-n" 'next-history-element)
(define-key minibuffer-local-completion-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-completion-map "\C-n" 'next-history-element)
(define-key minibuffer-local-must-match-map "\C-p" 'previous-history-element)
(define-key minibuffer-local-must-match-map "\C-n" 'next-history-element)

(add-hook 'shell-mode-hook
               '(lambda ()
                  (define-key shell-mode-map
                              "\C-n"
                              'comint-next-input)
                  (define-key shell-mode-map
                              "\C-p"
                              'comint-previous-input)
                  ))



;; auto-save
;(setq auto-save-default t)
(setq auto-save-default nil)
(setq auto-save-directory "~/") 
(setq auto-save-interval 100)
(setq auto-save-file-name-transforms '(("\\`/[^/]*:\\(.+/\\)*\\(.*\\)" "/tmp/\\2")))
;(setq auto-save-file-name-transforms
;      '(("\\`/[^/]*:\\(.+/\\)*\\(.*\\)" "/tmp/\\2")))




;;; m-x er
(defalias 'er 'eval-region)

;hunspell
(setq ispell-program-name "hunspell")
;(setq ispell-dictionary "")


;; Iswitchb rocks the house
;; (iswitchb-mode t)

(defun iswitchb-local-keys ()
  (mapc (lambda (K) 
   (let* ((key (car K)) (fun (cdr K)))
        (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
 '(("<right>" . iswitchb-next-match)
   ("<left>"  . iswitchb-prev-match)
   ("<up>"    . ignore             )
   ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

(icomplete-mode)

;; Misc settings
(setq visible-bell nil
      gnus-use-full-window nil
      ps-paper-type 'a4
      focus-follows-mouse t
      mark-even-if-inactive t
      truncate-partial-width-windows nil
      Man-notify-method 'pushy
;;      default-fill-column 78
;;      default-fill-column 77
      pop-up-windows t
      window-size-fixed nil
      scroll-preserve-screen-position t
      scroll-step 1
      pending-delete-mode 1
      even-window-heights nil
      auto-fill-mode nil
      highline-mode t
      windmove-wrap-around t)

;; speedbar
(defun speedbar-expand-all-lines ()
  "Expand all items in the speedbar buffer.
 But be careful: this opens all the files to parse them."
  (interactive)
  (goto-char (point-min))
  (while (not (eobp))
         (forward-line)
         (speedbar-expand-line)))

(setq speedbar-use-images nil)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(global-set-key [(f6)] 'speedbar-get-focus)

;; emacs-nav
(add-to-list 'load-path "~/.emacs.d/emacs-nav")
(global-set-key [(f7)] 'nav)
(require 'nav)

; make quickdir short
(defun nav-insert-jump-buttons ()
  ;; Make quickjump buttons.
  (insert "\n\n")
  (nav-insert-text "Quickjumps:" nav-face-heading)
  (insert "\n")
  (setq qfilename (replace-regexp-in-string "^.*/" "" (nth 0 nav-quickfile-list)))
  (insert-text-button (concat (propertize "5." 'face nav-face-button-num) " "
			      (propertize qfilename 'face nav-face-file))
		      :type 'quickfile-jump-button)
  (insert "\n")
  (setq qfilename (replace-regexp-in-string "^.*/" "" (nth 1 nav-quickfile-list)))
  (insert-text-button (concat (propertize "6." 'face nav-face-button-num) " "
			      (propertize qfilename 'face nav-face-file)) 
		      :type 'quickfile-jump-button)
  (insert "\n")
  (setq qfilename (replace-regexp-in-string "^.*/" "" (nth 2 nav-quickfile-list)))
  (insert-text-button (concat (propertize "7." 'face nav-face-button-num) " "
			      (propertize qfilename 'face nav-face-file)) 
		      :type 'quickfile-jump-button)
  (insert "\n")
  (setq qdirname (replace-regexp-in-string "^.*/" "" (nth 0 nav-quickdir-list)))
  (insert-text-button (concat (propertize "8." 'face nav-face-button-num) " " 
			      ;; (propertize (nth 0 nav-quickdir-list) 'face nav-face-dir))
			      (propertize qdirname 'face nav-face-dir))
		      :type 'quickdir-jump-button)
  (insert "\n")
  (setq qdirname (replace-regexp-in-string "^.*/" "" (nth 1 nav-quickdir-list)))
  (insert-text-button (concat (propertize "9." 'face nav-face-button-num) " "  
			      ;; (propertize (nth 1 nav-quickdir-list) 'face nav-face-dir))
			      (propertize qdirname 'face nav-face-dir))
		      :type 'quickdir-jump-button)
  (insert "\n")
  (setq qdirname (replace-regexp-in-string "^.*/" "" (nth 2 nav-quickdir-list)))
  (insert-text-button (concat (propertize "0." 'face nav-face-button-num) " "  
			      ;; (propertize (nth 2 nav-quickdir-list) 'face nav-face-dir))
			      (propertize qdirname 'face nav-face-dir))
		      :type 'quickdir-jump-button))



;; setting window split to Horizontal
(setq split-height-threshold nil) (setq split-width-threshold 0)

