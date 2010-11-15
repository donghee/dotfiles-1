;; korean.el
(provide 'korean)

;; hangul setting
;; 
;; euc-kr 에 관한 설정 중에 어떤 것이 window쪽과 copy paste하는데 문제를 일으킴
;;   default 상태인 경우에는 문제 없이 copy & paste가 잘 된다. [2006-07-27 11:03]
(when enable-multibyte-characters
  (set-language-environment "Korean")
  
  ; (setq-default file-name-coding-system 'euc-kr)
  ;; the following setting is unnecessary from 20.5 >
  (when (string-match "^3" (or (getenv "HANGUL_KEYBOARD_TYPE") ""))
    (setq default-korean-keyboard "3"))
  (setq input-method-verbose-flag nil
        input-method-highlight-flag nil)
  ; (prefer-coding-system 'euc-kr)
  ;; (prefer-coding-system 'utf-8)  		; utf-8 환경 설정
  
  ; (set-buffer-file-coding-system 'euc-kr)
  ; (set-terminal-coding-system 'euc-kr)
  ; (set-default-coding-systems 'euc-kr)
  
  ; (setq default-process-coding-system '(euc-kr . euc-kr))
  (when window-system 
    (global-set-key "\C-\\" 'undefined))
  (add-hook 'quail-inactivate-hook 'delete-quail-completions)
  (defun delete-quail-completions ()
    (when (get-buffer "*Quail Completions*")
      (kill-buffer "*Quail Completions*")))

  (unless window-system
    (set-keyboard-coding-system 'euc-kr)
    (set-terminal-coding-system 'euc-kr)
    (define-key encoded-kbd-mode-map [27] nil))

  ; (setq selection-coding-system 'euc-kr)
  ; (setq selection-coding-system 'ctext)

  ;; Hangul Mail setting
  ; (setq-default sendmail-coding-system 'euc-kr)

  ;; turn off C-h during input
  (eval-after-load "quail"
    '(progn
       (define-key quail-translation-keymap "\C-h" 'quail-delete-last-char)
       (define-key quail-translation-keymap (kbd "C-SPC") 'set-mark-command)
       (define-key quail-translation-keymap "\C-?" 'quail-translation-help)))
  (define-key global-map (kbd "C-x RET s") 'decode-coding-region))

(unless (or enable-multibyte-characters window-system)
  (standard-display-european t)
  (set-input-mode (car (current-input-mode))
                  (nth 1 (current-input-mode))
                  0))

;; font setting : LucidaTypewrite
;;          jmjeong@gmail.com
(unless win32p
  (when window-system
	(progn
	  (create-fontset-from-fontset-spec
	   "LucidaTypewrite,
ascii:-*-LucidaTypewriter-Medium-R-Normal-Sans-14-*-*-*-*-*-ISO8859-1")
										;  korean-ksc5601:-Sun-Gothic-Medium-R-Normal--14-*-*-*-*-*-KSC5601.1987-0")
	  (set-face-font 'default "LucidaTypewrite"))))

; Korean font를 지정한 경우에는 bold 처리가 잘 안 됨 [2006-07-19]
; Lucidatypewrite가 coding하기에는 적당해 보이나, 영문 입력 후에 한글을 입력한 경우 줄 간격 이동이 생김(보기 흉함)
;   italic과 slant에 대해서 어떻게 할건지 고려
; 
;korean-ksc5601:-Sun-Gothic-Medium-R-Normal--14-*-*-*-*-*-KSC5601.1987-0")
;  )

;;; settings from dtkim@camars.kaist.ac.kr
(when win32p
  (when (eq system-type 'windows-nt)
    (setq load-path (append load-path
                            (list (concat data-directory "../leim"))))
    (load "leim-list.el" t))
  ;; =============================================================
  ;; Fonts and Frame for Windows 95/NT
  ;; For multilingual display, get fonts from 
  ;; http://www.microsoft.com,
  ;; http://babel.uoregon.edu/yamada/guides.html
  ;; =============================================================

  ;; To see list of fonts in your Windows 95/NT,
  ;; (w32-select-font) or
  ;; (insert (prin1-to-string (x-list-fonts "*"))) 

  ;; alternative fonts:
  ;; Gulimche:
  ;; korean-ksc5601:-*-\261\274\270\262\303\274-normal-r-*-*-16-*-*-*-c-*-ksc5601-*,
  ;; Batangche:
  ;;  korean-ksc5601:-*-\271\331\305\301\303\274-normal-r-*-*-16-*-*-*-c-*-ksc5601-*,
  ;; Dodumche:
  ;;  korean-ksc5601:-*-\265\270\277\362\303\274-normal-r-*-*-16-*-*-*-c-*-ksc5601-*,
  ;; Gungseoche:
  ;;  korean-ksc5601:-*-\261\303\274\255\303\274-normal-r-*-*-16-*-*-*-c-*-ksc5601-*,
  ;;  chinese-gb2312:-*-MS Song-normal-r-*-*-*-*-*-*-c-*-gb2312-*,

  (create-fontset-from-fontset-spec
   "-*-Fixedsys-normal-r-*-*-12-*-*-*-c-*-fontset-msfixedsys12,
    latin-iso8859-1:-*-Fixedsys-normal-r-*-*-12-*-*-*-c-*-iso8859-1,
    latin-iso8859-2:-*-Courier New CE-normal-r-*-*-*-*-*-*-c-*-iso8859-2,
    latin-iso8859-3:-*-Courier New Tur-normal-r-*-*-*-*-*-*-c-*-iso8859-3,
    latin-iso8859-4:-*-Courier New Baltic-normal-r-*-*-*-*-*-*-c-*-iso8859-4,
    cyrillic-iso8859-5:-*-Courier New Cyr-normal-r-*-*-*-*-*-*-c-*-iso8859-5,
    greek-iso8859-7:-*-Courier New Greek-normal-r-*-*-*-*-*-*-c-*-iso8859-7,
    korean-ksc5601:-*-\261\274\270\262\303\274-normal-r-*-*-12-*-*-*-c-*-ksc5601-*,

    japanese-jisx0208:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    japanese-jisx0212:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    katakana-jisx0201:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    chinese-gb2312:-*-MS Hei-normal-r-*-*-*-*-*-*-c-*-gb2312-*,
    chinese-big5-1:-*-MingLiU-normal-r-*-*-*-*-*-*-c-*-big5-1,
    chinese-big5-2:-*-MingLiU-normal-r-*-*-*-*-*-*-c-*-big5-2"
   t)
  (create-fontset-from-fontset-spec
   "-*-Courier New-normal-r-*-*-12-*-*-*-c-*-fontset-mscourier12,
    latin-iso8859-1:-*-Courier New-normal-r-*-*-12-*-*-*-c-*-iso8859-1,
    latin-iso8859-2:-*-Courier New CE-normal-r-*-*-*-*-*-*-c-*-iso8859-2,
    latin-iso8859-3:-*-Courier New Tur-normal-r-*-*-*-*-*-*-c-*-iso8859-3,
    latin-iso8859-4:-*-Courier New Baltic-normal-r-*-*-*-*-*-*-c-*-iso8859-4,
    cyrillic-iso8859-5:-*-Courier New Cyr-normal-r-*-*-*-*-*-*-c-*-iso8859-5,
    greek-iso8859-7:-*-Courier New Greek-normal-r-*-*-*-*-*-*-c-*-iso8859-7,
    korean-ksc5601:-*-\261\274\270\262\303\274-normal-r-*-*-12-*-*-*-c-*-ksc5601-*,
    japanese-jisx0208:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    japanese-jisx0212:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    katakana-jisx0201:-*-MS Gothic-normal-r-*-*-12-*-*-*-c-*-jisx0212-sjis,
    chinese-gb2312:-*-MS Hei-normal-r-*-*-*-*-*-*-c-*-gb2312-*,
    chinese-big5-1:-*-MingLiU-normal-r-*-*-*-*-*-*-c-*-big5-1,
    chinese-big5-2:-*-MingLiU-normal-r-*-*-*-*-*-*-c-*-big5-2"
   t)
  (setq w32-enable-italics t)
  (setq w32-use-w32-font-dialog nil)
  ;; for better font dialog menu for fontset
  ;;(setq w32-enable-unicode-output nil)

  (loop for param in
        '((scroll-bar-width . 7)
          ;; Choose only one for your default font set.
          ;;(font . "-*-Courier New-normal-r-*-*-13-*-*-*-c-*-fontset-standard")
          (font . "-*-Fixedsys-normal-r-*-*-12-*-*-*-c-*-fontset-msfixedsys12")
	  ;;(font . "-*-Courier New-normal-r-*-*-12-*-*-*-c-*-fontset-mscourier12")
	  (top . -25)
	  (left . -1)
	  (width . 85)
	  (height . 60)
	  (background-color . "Wheat")
	  (foreground-color . "Black")
	  (vertical-scroll-bars . right))
	do
	(setf (frame-parameter nil (car param)) (cdr param))
	(setf (default-frame-parameter (car param)) (cdr param))))

; (setq coding-system-for-read 'euc-kr coding-system-for-write 'euc-kr)
; (setq coding-system-for-read 'euc-kr coding-system-for-write 'utf-8)

;;; end of dtkim@camars.kaist.ac.kr

;; EOF
