;; load php-mode
(put 'upcase-region 'disabled nil)
;(require 'php-mode)

;; python-mode
(require 'python-mode)
   
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))   
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; for unittest
(setq mode-compile-always-save-buffer-p t)
(setq mode-compile-save-all-p t)
;(setq compilation-window-height 30)

(defun py-unittest ()
"run unittest on file in the current buffer "
    (interactive)
    (save-buffer buffer-file-name)
    (compile
     (format 
      "python \"%s\""
        (buffer-file-name))
))

(defun runtests () (interactive)
    (compile "python /somepath/Twisted/admin/runtests"))

(defun py-execute-line ()
  "Executes the current line of Python code."
  (interactive)
  (py-execute-region (line-beginning-position)
                     (line-end-position))
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
    (setq-default w32shell-shell "cmd")
    (auto-fill-mode -1)
    (define-key py-mode-map [f4] 'py-shell)
    (define-key py-mode-map [f5] 'py-execute-buffer)
   (define-key py-mode-map [f6] 'py-unittest)
    (define-key py-mode-map [f7] 'test-case-run)    
    ))


(add-hook 'python-mode-hook
  '(lambda ()
    (define-key py-mode-map "\C-c\C-j" 'py-execute-line)
    (define-key py-mode-map "\C-c\C-e" 'py-execute-block)))

(add-hook 'python-mode-hook
          '(lambda()
;             (require 'pycomplete)
             (setq indent-tabs-mode nil)))

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

(defadvice py-execute-buffer 
  (after py-execute-buffer)
  (save-buffer buffer-file-name)
  (other-window -1)
)

(ad-activate 'py-execute-buffer)

;; pylookup

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

