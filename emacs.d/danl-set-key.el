;; danl-set-key.el -- A convenient way for binding keys
;; Copyright (C) 2001 Daniel Lundin <daniel@codefactory.se>

;; Filename: danl-set-key.el
;; Author: Daniel Lundin <daniel@codefactory.se>
;; Maintainer: Daniel Lundin <daniel@codefactory.se>
;; Created: 2 Mar 2001
;; Version: 1.0
;; Keywords: key,binding,keyboard

;; This file is not part of Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; This is a convenient replacement for global-set-key to allow easy
;; binding to functions with arguments (or any expression for that matter).

;; Example: 

;; (require 'danl-set-key)
;; (danl-global-set-key [next] '(scroll-up 5))
;; (danl-global-set-key [f2] '(message "Two plus two is %i" (+ 2 2)))


;;; Code:


;;;### autoload
(defun danl-define-key (keymap key def)
 "Define KEY in KEYMAP like 'define-key' but automatically create an
anonymous function if DEF is an expression."
 (define-key keymap key (if (listp def) 
			    `(lambda () (interactive) ,def) 
			  def)))


;;;### autoload
(defun danl-local-set-key (key command)
  "Give KEY a local binding as COMMAND, like 'local-set-key' but
COMMAND may be any expression."
  (interactive "KSet key locally: \nxSet key %s locally to command: ")
  (let ((map (current-local-map)))
    (or map
	(use-local-map (setq map (make-sparse-keymap))))
    (or (vectorp key) (stringp key)
	(signal 'wrong-type-argument (list 'arrayp key)))
    (danl-define-key map key command)))


;;;### autoload
(defun danl-global-set-key (key command)
 "Globally set KEY to COMMAND, which can have an argument list"
  (interactive "KSet key globally: \nxSet key %s to expression: ")
  (or (vectorp key) (stringp key)
      (signal 'wrong-type-argument (list 'arrayp key)))
   (danl-define-key (current-global-map) key command))


(provide 'danl-set-key)
;;; danl-global-set-key.el ends here