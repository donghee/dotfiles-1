;;; search-google
(defun search-google ()
    "Prompt for a query in the minibuffer, launch the web browser and query google."
 (interactive)
 (let ((search (read-from-minibuffer "Google Search: ")))
  (browse-url (concat "http://www.google.com/search?q=" search))))

(defun search-wikipedia ()
    "Prompt for a query in the minibuffer, launch the web browser and query wikipedia."
 (interactive)
 (let ((search (read-from-minibuffer "Wikipedia Search: ")))
  (browse-url (concat "http://www.wikipedia.org/w/wiki.phtml?search=" search))))

(defun search-googlescholar ()
    "Prompt for a query in the minibuffer, launch the web browser and query google scholar."
 (interactive)
 (let ((search (read-from-minibuffer "Google Scholar Search: ")))
  (browse-url (concat "http://scholar.google.com/scholar?q=" search))))


;; dark room
(defun fullscreen ()
   (interactive)
   (setq default-left-margin-width 24)
   (setq default-right-margin-width 24)
   (set-window-margins nil 24 24 )
   (set-fringe-style '(0 . 0))
   (menu-bar-mode -1)
   (set-frame-parameter nil 'fullscreen
                        (if (frame-parameter nil 'fullscreen) nil
                          'fullboth)))

(defun autospacing (s e) 
  (interactive "r")
 (goto-char e)
 (insert "\n")
 (call-process "/home/dak/bin/autospacing" nil t nil (buffer-substring s e))
 (insert "\n")
)
