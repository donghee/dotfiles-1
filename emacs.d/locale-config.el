;;; set-locale
(set-language-environment "Korean")   
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(set-terminal-coding-system 'utf-8)

(defun toggle-locale ()
    (interactive)
    (cond ((eq buffer-file-coding-system 'utf-8-unix)
          (set-buffer-file-coding-system 'euc-kr)
          (set-default-coding-systems 'euc-kr)
          (set-keyboard-coding-system 'euc-kr)
          (setq coding-system-for-read 'euc-kr)
          (set-terminal-coding-system 'euc-kr))
         ((eq buffer-file-coding-system 'euc-kr-unix)
          (set-buffer-file-coding-system 'utf-8)
          (set-default-coding-systems 'utf-8)
          (set-keyboard-coding-system 'utf-8)
          (setq coding-system-for-read 'utf-8)
          (set-terminal-coding-system 'utf-8))
     )
)