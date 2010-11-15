;;; define global set key
(defun danl-global-set-key (key cmd)
 "Globally set KEY to CMD, which can as opposed to 'global-set-key'
 have an argument list"
  (interactive "KSet key globally: \nxSet key %s to expression: ")
  (or (vectorp key) (stringp key)
      (signal 'wrong-type-argument (list 'arrayp key)))
   (define-key (current-global-map) key
     (if (listp cmd) `(lambda () (interactive) ,cmd) cmd)))

(danl-global-set-key [?\C-\047] 'other-window)
(danl-global-set-key [C-tab] 'other-window) ;C-x o
(danl-global-set-key [?\C-\073] '(other-window -1))


(danl-global-set-key [?\204] 'other-window)
(danl-global-set-key [?\226] '(other-window -1))


(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [\M-\S-up] 'move-text-up)
(global-set-key [\M-\S-down] 'move-text-down) 


;;-- enlarger window --
(global-set-key [S-f9] 'enlarge-window) ; Shift+f9 is enlarge window


;; mouse wheel 
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)


(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))

(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot) 

(setq mwheel-scroll-amount '(8 . 25))
(setq mouse-yank-at-point t)

(danl-global-set-key [pause] 'dpp-toggle-window-dedicated)

(danl-global-set-key [end] 'shrink-window)
(danl-global-set-key [S-end] '(shrink-window 5))
(danl-global-set-key [home] 'enlarge-window)
(danl-global-set-key [S-home] '(enlarge-window 5))
(danl-global-set-key [M-end] 'shrink-window-horizontally)
(danl-global-set-key [S-M-end] '(shrink-window-horizontally 10))
(danl-global-set-key [M-home] 'enlarge-window-horizontally)
(danl-global-set-key [S-M-home] '(enlarge-window-horizontally 10))

(danl-global-set-key [M-left] 'scroll-right)
(danl-global-set-key [M-right] 'scroll-left)
(danl-global-set-key [M-down] '(scroll-up 2))
(danl-global-set-key [M-up] '(scroll-down 2))


(danl-global-set-key [\M-Nv] 'indent-for-comment)

(setq delete-key-deletes-forward t)

;(danl-global-set-key "\C-z" 'undo)

;(danl-global-set-key "\M-m" 'compile)
(danl-global-set-key "\C-cc" 'compile)

(danl-global-set-key "\C-cd" 'eshell)
;(danl-global-set-key "\C-cs" 'run-half-eshell)

(danl-global-set-key "\M-s" 'save-buffer)

(danl-global-set-key "\M-g" 'goto-line)

;(danl-global-set-key [f5] 'new-frame)

(danl-global-set-key "\M-]" 'forward-paragraph)
(danl-global-set-key "\M-[" 'backward-paragraph)


(danl-global-set-key "\C-\M-n" '(scroll-up 2))
(danl-global-set-key "\C-\M-p" '(scroll-down 2))


(danl-global-set-key [\s-return] '(scroll-up 2))

(danl-global-set-key [?\C-\047] 'other-window)
(danl-global-set-key [C-tab] 'other-window) ;C-x o
(danl-global-set-key [?\C-\073] '(other-window -1))

(danl-global-set-key [?\C-\042] 'other-frame)
(danl-global-set-key [?\C-\072] '(other-frame-1))

(danl-global-set-key [?\204] 'other-window)
(danl-global-set-key [?\226] '(other-window -1))

(danl-global-set-key [?\M-\204] 'other-frame)
(danl-global-set-key [?\M-\226] '(other-frame -1))

;; Ctrl+Space make start selection on EmacsW32
(global-set-key [C-kanji] 'set-mark-command)


;; bs cycling is pretty cool too
(danl-global-set-key [prior] 'bs-cycle-previous)
(danl-global-set-key [next] 'bs-cycle-next)
(danl-global-set-key [M-next] 'bs-select-next-configuration)

;; execute-extended-command Meta-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; dictionary-el
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
