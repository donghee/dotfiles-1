;;; org-mode
(require 'org-publish)

(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "/work/cygwin/home/donghee/doc/org/"
         :base-extension "org"
         :publishing-directory "/work/cygwin/home/donghee/doc/org/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("clubhouse"
         :base-directory "/work/cygwin/home/donghee/doc/org/clubhouse/"
         :base-extension "org"
         :publishing-directory "/work/cygwin/home/donghee/doc/org/clubhouse/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("mentorschool"
         :base-directory "/work/cygwin/home/donghee/doc/org/mentorschool/"
         :base-extension "org"
         :publishing-directory "/work/cygwin/home/donghee/doc/org/mentorschool/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("ksad2010"
         :base-directory "/work/cygwin/home/donghee/doc/org/ksad2010/"
         :base-extension "org"
         :publishing-directory "/work/cygwin/home/donghee/doc/org/ksad2010/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("socialledbug"
         :base-directory "/work/cygwin/home/donghee/doc/org/socialledbug/"
         :base-extension "org"
         :publishing-directory "/work/cygwin/home/donghee/doc/org/socialledbug/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        )
)


(setq enable-local-variables :all)
(require 'org-latex)
(require 'org-html)

(add-hook 'org-mode-hook
    (lambda ()
    (define-key org-mode-map [f5] 'org-export-upload)
    (auto-fill-mode -1)))

(setq org-export-htmlize-output-type "css")

(setq org-export-allow-BIND t)

(setq org-log-done t)

(setq org-export-creator-info nil)

(setq org-export-latex-classes (cons '("koarticle"
     "% BEGIN My Article Defaults
\\documentclass[a4paper,10pt,nokorean]{article} 
\\usepackage{kotex}
\\usepackage[letterpaper,includeheadfoot,top=0.5in,bottom=0.5in,left=0.75in,right=0.75in]{geometry}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{hyperref}
\\usepackage{graphicx}
\\usepackage{lastpage}
\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\renewcommand{\\headrulewidth}{1pt}
\\renewcommand{\\footrulewidth}{0.5pt}

% Default footer
% \\fancyfoot[L]{\\small \\jobname \\\\ \\today}
\\fancyfoot[L]{\\small \\today}
\\fancyfoot[C]{\\small Page \\thepage\\ of \\pageref{LastPage}}
\\fancyfoot[R]{\\small \\copyright \\the\\year\\  Donghee Park}
% END My Article Defaults

"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                                     org-export-latex-classes))

;; Mobile org

(setq org-directory "c:/work/cygwin/home/donghee/doc/org")
(setq org-mobile-directory "c:/work/cygwin/home/donghee/doc/org")
(setq org-mobile-inbox-for-pull (concat org-directory "inbox-pull.org"))

(setq org-log-done t)

(setq cygwin-home "c:/work/cygwin/home/donghee/")

(defadvice org-mobile-pull (before org-mobile-download activate)
;  (setq w32shell-shell "cygwin")
  (shell-command (concat cygwin-home "/bin/org-sync.sh down"))
;  (shell-command (concat cygwin-home "bin/org-download.sh"))
  (revert-buffer t t t)
  (redraw-display)
)

(defadvice org-mobile-push (after org-mobile-upload activate)
;; (shell-command  (concat cygwin-home  "bin/org-upload-min.sh"))
;  (setq w32shell-shell "cygwin")
  (shell-command (concat cygwin-home  "bin/org-upload-min.sh")) ;; with out buffer
  (delete-other-windows)
  (message "org-mobile-pushed")
)

(setq org-directory  (concat cygwin-home "doc/org/")
;      org-mobile-directory (concat org-directory "staging/")
;      org-mobile-inbox-for-pull (concat org-directory "inbox-pull.org")
)

;(org-publish-timestamp-directory "~/.emacs.d/org-files/.org-timestamps/")
; do no timestamp checking and always publish all files
(setq org-publish-use-timestamps-flag nil)

(add-to-list 'load-path "~/.emacs.d/org-s5")
(require 'org-s5)

;; for org-babel
;; (add-to-list 'load-path "c:/work/cygwin/home/donghee/.emacs.d/org-mode")
;; (add-to-list 'load-path "c:/work/cygwin/home/donghee/.emacs.d/org-mode/lisp")
;; (add-to-list 'load-path "c:/work/cygwin/home/donghee/.emacs.d/org-mode/contrib/babel")
;; (add-to-list 'load-path "c:/work/cygwin/home/donghee/.emacs.d/org-mode/contrib/lisp")

;; (require 'org-babel-init)
;; (require 'org-babel-R)
;; ;(require 'org-babel-ruby)      ;; requires ruby, irb, ruby-mode, and
;; (require 'org-babel-python)    ;; requires python, and python-mode
;; (org-babel-load-library-of-babel)


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
\\setbeamerfont{frametitle}{size=\\Large}

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

;     ("\\takahashi{%s}" . "\\takahashi{\\stack{%s}}")
     ;; ("\\frame{%s}" . "\\frame*{%s}")
     ;; ("\\section{%s}" . "\\section*{%s}")
     ;; ("\\subsection{%s}" . "\\subsection*{%s}")
     ;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ;; ("\\paragraph{%s}" . "\\paragraph*{%s}")))


;; org export latex save-hook

(defun org-export-latex-upload ()
  (let (fname)
    (setq fname (file-name-nondirectory buffer-file-name))
;       (message buffer-file-name) ; 멘토스쿨 디렉토리 안에 있는거 안올라감. org 다음 디렉토리 읽어서 lcd 해야함.
    (setq orgfname  (concat (file-name-sans-extension fname) ".org"))
;       (message orgfname)
    (message "Start uploading")
;    (shell-command (concat cygwin-home "/bin/org-sync.sh up"))

    (async-shell-command (concat cygwin-home "/bin/org-sync.sh up"))
;    (shell-command (format (concat cygwin-home "/bin/org-upload-one2.sh %s %s %s") fname orgfname ""))
    (delete-other-windows)
    (message (concat "Uploaded" orgfname " to picnic server"))
))


(defun org-export-upload ()
  (interactive)
  (message "Start uploading")
  (async-shell-command (concat cygwin-home "/bin/org-sync.sh up"))
  (delete-other-windows)
  (message (concat "Upload Modified files to picnic server"))
)


;; (defun org-export-latex-upload ()
;; (message "Start uploading")
;; (shell-command  (concat cygwin-home  "bin/org-upload-min.sh"))
;; (delete-other-windows)
;; (message "Uploaded org files to picnic server")
;; )


(add-hook 'org-export-latex-after-save-hook 'org-export-latex-upload)
;; add to org-export-html-after-save-hook to org-html.el
;;(defvar org-export-html-after-save-hook nil
;;  "Hook run in the finalized Html buffer, after it has been saved.")
;;  ...
;;     (or to-buffer (save-buffer))
;;        (run-hooks 'org-export-html-after-save-hook)
;; ...

;(add-hook 'org-export-html-after-save-hook 'org-export-latex-upload)


