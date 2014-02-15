;; show backtrace when error
(setq debug-on-error t)

;; for windows
(when (eq system-type 'windows-nt)
  ;; 设置set-mark-command按键C-S-SPC，避免和切换输入法冲突
  (global-set-key (kbd "C-S-SPC") 'set-mark-command)

  ;; make PC keyboard's Win key or other to type Super or Hyper, for emacs running on Windows.
  (setq w32-pass-lwindow-to-system nil
        w32-pass-rwindow-to-system nil
        w32-pass-apps-to-system nil
        w32-lwindow-modifier 'super ; Left Windows key
        w32-rwindow-modifier 'super ; Right Windows key
        w32-apps-modifier 'hyper)) ; Menu key

;; Allow access from emacsclient
(when (not (eq system-type 'windows-nt))
  (require 'server)
  (unless (server-running-p)
    (server-start)))

;; Smex -- M-x enhancement
(prelude-require-package 'smex)
(global-set-key (kbd "M-x") 'smex)

;; 关闭flx-ido-mode，因为按左右键选择文件或buffer时，Emacs无限占用内存，从几十M吃到2G多，最后死掉
(flx-ido-mode -1)

;; search ignore the case, if you specify the text in lower case
(setq case-fold-search t)

;; 80 column
;; don't highlight long lines tail, which activated in prelude-editor.el
(delq 'lines-tail whitespace-style)
;; 高亮指定列
;;(prelude-require-package 'column-marker)
;; 一条竖线
;; (prelude-require-package 'fill-column-indicator)

;; 禁用鼠标离开时自动保存
(remove-hook 'mouse-leave-buffer-hook 'prelude-auto-save-command)

;; when doing save, if dirs not exist, prompt create it.
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;; 完全禁止beep
(setq ring-bell-function (lambda () ()))

;; hide terminal menu bar
(menu-bar-mode -1)

;; hide scroll bar
(when (fboundp 'toggle-scroll-bar) (toggle-scroll-bar -1))

;; make the fringe (gutter) bigger, in pixels (the default is 8, the prelude is 4)
(if (fboundp 'fringe-mode)
    (fringe-mode 6))

;; Make mouse wheel / trackpad scrolling less jerky
;;(setq mouse-wheel-scroll-amount '(0.001))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ; scroll window under mouse
(setq scroll-step 1) ; keyboard scroll one line at a time

;; eshell
(setq eshell-cmpl-ignore-case t)

;; markdown preview chinese
(setq default-process-coding-system '(utf-8 . utf-8))

;; javascript mode
(setq js-indent-level 2)

;; xml indent
(setq nxml-child-indent 2)

;; theme
;;(load-theme 'solarized-dark)
;; (load-theme 'solarized-light)
;; (load-theme 'zenburn)

;; maximize frame when startup
(prelude-require-package 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; Set transparency
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

;; set font size, 13pt
(set-face-attribute 'default nil :height 130)
;; 解决注释中中文字符乱码问题
;; Fix the garbage problem of Chinese characters in comments.
;; Set-fontset-font mast be after set-face-attribute
;; http://blog.oasisfeng.com/2006/10/19/full-cjk-unicode-range/
;; 中文，不包括标点
(set-fontset-font (frame-parameter nil 'font) 'han '("SimSun" . "unicode-bmp"))
;; CJK标点符号：3000-303F
(set-fontset-font (frame-parameter nil 'font) '(#x3000 . #x303F) '("SimSun" . "unicode-bmp"))
;; 全角ASCII、全角中英文标点、半宽片假名、半宽平假名、半宽韩文字母 FF00-FFEF
(set-fontset-font (frame-parameter nil 'font) '(#xFF00 . #xFFEF) '("SimSun" . "unicode-bmp"))
;; CJK部首补充：2E80-2EFF
(set-fontset-font (frame-parameter nil 'font) '(#x2E80 . #x2EFF) '("SimSun" . "unicode-bmp"))
;; CJK笔划：31C0-31EF
(set-fontset-font (frame-parameter nil 'font) '(#x31C0 . #x31EF) '("SimSun" . "unicode-bmp"))

;; google translate
(prelude-require-package 'google-translate)
(require 'google-translate)
(global-set-key (kbd "C-t") 'google-translate-at-point)
(global-set-key (kbd "M-t") 'google-translate-query-translate)
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "zh-CN")

;; org mode
(require 'org)
(setq org-list-indent-offset 2)
(setq org-agenda-files '("~/logbook"))
(setq org-tag-alist '(("java" . ?j) ("web" . ?w) ("linux" . ?l) ("text" . ?t) ("mac" . ?m) ("en_word") ("emacs" . ?e) ("程序设计") ("微博")))
(setq org-startup-truncated nil)
;; M-<tab> is pcomplete
;; (add-hook 'flyspell-mode-hook
;;           (lambda ()
;;               (define-key flyspell-mode-map (kbd "M-<tab>") nil)
;;               (define-key flyspell-mode-map (kbd "C-M-i") nil)))
;; ‘a_b’ will not be interpreted as a subscript, but ‘a_{b}’ will.
(setq org-use-sub-superscripts '{})
;; publishing
;; use infojs
(setq org-export-html-coding-system 'utf-8-unix)
(setq org-export-html-use-infojs t)
;; options see http://orgmode.org/org.html#JavaScript-support
(setq org-infojs-options '((path . "js/org-info.js")
                           (view . "overview")
                          (toc . "0")
                          (ftoc . "0")
                          (tdepth . "max")
                          (sdepth . "max")
                          (mouse . nil)
                          (buttons . "0")
                          (ltoc . "0")
                          (up . "./")
                          (home . "/")))
(setq org-export-html-preamble nil)  ; http://orgmode.org/org.html#HTML-preamble-and-postamble
;;(setq org-export-html-preamble-format '(("en" "<p>test a %t %a %e %d %%</p>")))
(setq org-export-html-postamble t)
(setq org-export-html-postamble-format '(("en" "<hr/><p>%a - %d - Generated by %c - %v</p>")))
(setq org-publish-project-alist
      '(("logbook"
         :base-directory "~/logbook"
         :base-extension "org"
;;         :recursive t ; 也发布子目录。还会导致Emacs假死，CPU占用80%，持续10，不知道什么原因
         :exclude "gtd.org\\|journal.org\\|notes.org\\|wordnote.org\\|math.org\\|sitemap.org\\|theindex.org"
         :publishing-directory "~/Sites/logbook/"
         :publishing-function org-publish-org-to-html
         :section-numbers t
         :table-of-contents nil
         :makeindex t
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Sitemap"
         :sitemap-sort-files anti-chronologically ; desc by date
         :sitemap-ignore-case t
         :style "<link rel=\"stylesheet\"
                         href=\"css/stylesheet.css\"
                         type=\"text/css\"/>")
        ("logbook-static"
         :base-directory "~/logbook"
         :exclude "ltxpng"
;;         :include ("/CNAME")
         :base-extension "css\\|js\\|ico\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :recursive t
         :publishing-directory "~/Sites/logbook/"
         :publishing-function org-publish-attachment
         )
        ("org" :components ("logbook" "logbook-static"))))
;; org export html code highlight
(prelude-require-package 'htmlize)
;; org capture
(setq org-directory "~/logbook")
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/logbook/inbox.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/logbook/inbox.org")
         "* %?\nEntered on %U\n  %i\n  %a")))
;; org Embedded Latex

;; Auto Complete
(prelude-require-package 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" prelude-personal-dir))
(ac-config-default)
(global-auto-complete-mode t)
(global-set-key (kbd "M-/") 'auto-complete)
(ac-set-trigger-key "TAB")
(setq-default ac-sources '(ac-source-yasnippet
                           ac-source-filename
                           ac-source-words-in-all-buffer
                           ac-source-functions
                           ac-source-variables
                           ac-source-symbols
                           ac-source-features
                           ac-source-abbrev
                           ac-source-words-in-same-mode-buffers
                           ac-source-dictionary
                           ac-source-files-in-current-dir))
(add-hook 'eshell-mode-hook
          (lambda () (auto-complete-mode)))
