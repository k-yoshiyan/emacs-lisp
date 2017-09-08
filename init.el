;;全画面 
(setq initial-frame-alist 
'((top . 1) (left . 40) (width . 150) (height . 62)))

;; emacs clientから接続可能にする
(server-start)

;;フォントサイズ
(add-to-list 'default-frame-alist
             '(font . "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"))

;; 起動時に2分割
(setq w (selected-window))
(setq w2 (split-window w nil t))

;; visual-line-mode 
;(global-visual-line-mode) 
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(define-key global-map [f5] 
'(lambda () 
(interactive) 
(insert (format-time-string "%Y/%m/%d"))))

(define-key global-map [f6] 
'(lambda () 
(interactive) 
(insert (format-time-string "[%H:%M:%S]"))))

;; 起動時初期画面の抑止 
(setq inhibit-startup-message t)

;;; 履歴を次回Emacs起動時にも保存する 
(savehist-mode 1) 
;;; ファイル内のカーソル位置を記憶する 
(setq-default save-place t) (require 'saveplace) 
;;; 対応する括弧を表示させる 
(show-paren-mode 1) 

;; 起動時初期画面の抑止 
(setq inhibit-startup-message t)

;;; 履歴を次回Emacs起動時にも保存する 
(savehist-mode 1) 
;;; ファイル内のカーソル位置を記憶する 
(setq-default save-place t) (require 'saveplace) 
;;; 対応する括弧を表示させる 
(show-paren-mode 1) 
;;; モードラインに時刻を表示する 
(display-time) 
;;; 行番号・桁番号を表示する 
(line-number-mode 1) 
(column-number-mode 1) 
;;; リージョンに色をつける 
(transient-mark-mode 1)
; load-pathの追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))

; パッケージへのアクセス
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)


; recentf
(setq recentf-max-saved-items 500) 
(require 'recentf-ext) 
(global-set-key (kbd "C-x C-r") 'recentf-open-files) 
;; 起動画面で recentf を開く 
(add-hook 'after-init-hook (lambda() 
(recentf-open-files) 
))

;; next buffer - f7 & f8 
(global-set-key [f7] 'previous-buffer) 
(global-set-key [f8] 'next-buffer)

;; 起動時に2分割 
;(setq w (selected-window)) 
;(setq w2 (split-window w nil t))

;;
;; backup の保存先
;;
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages (quote (recentf-ext))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Dired-x
(setq dired-load-hook '(lambda () (load "dired-x"))) 
(setq dired-guess-shell-alist-user
   '(("\\.\\(ppt\\|PPT\\|pptx\\|PPTX\\)\\'" "open -a Keynote")
     ("\\.\\(xls\\|XLS\\|xlsx\\|XLSX\\)\\'" "qlmanage -p")
     ("\\.\\(jpg\\|JPG\\|png\\|PNG\\|pdf\\|PDF\\)\\'" "qlmanage -p")
     ("\\.\\(m4a\\|mp3\\|wav\\)\\'" "afplay -q 1 * &")))

;; weblio
(require 'eww)
(defvar eww-data)
(defun eww-current-url ()
  "バージョン間の非互換を吸収する。"
  (if (boundp 'eww-current-url)
      eww-current-url                   ;emacs24.4
    (plist-get eww-data :url)))         ;emacs25

(defun eww-set-start-at (url-regexp search-regexp)
  "URL-REGEXPにマッチするURLにて、SEARCH-REGEXPの行から表示させる"
  (when (string-match url-regexp (eww-current-url))
    (goto-char (point-min))
    (when (re-search-forward search-regexp nil t)
      (recenter 0))))

(defun region-or-read-string (prompt &optional initial history default inherit)
  "regionが指定されているときはその文字列を取得し、それ以外では`read-string'を呼ぶ。"
  (if (not (region-active-p))
      (read-string prompt initial history default inherit)
    (prog1
        (buffer-substring-no-properties (region-beginning) (region-end))
      (deactivate-mark)
      (message ""))))

(defun eww-render--after (&rest _)
  (eww-set-start-at "www.weblio.jp" "^ *Weblio 辞書")
  ;; 他のサイトの設定も同様に追加できる
  )
;;; [2017-01-14 Sat]バージョンごとに分岐
(if (boundp 'eww-after-render-hook)     ;25.1
    (add-hook 'eww-after-render-hook 'eww-render--after)
  (advice-add 'eww-render :after 'eww-render--after)) ;24.4

;;; weblio
(defun weblio (str)
  (interactive (list
                (region-or-read-string "Weblio: ")))
  (eww-browse-url (format "http://www.weblio.jp/content/%s"
                      (upcase (url-hexify-string str)))))
;;; wikipedia
(defun wikipedia (str)
  (interactive (list
                (region-or-read-string "Wikipedia: ")))
  (eww-browse-url (format "https://ja.wikipedia.org/wiki/%s"
                      (upcase (url-hexify-string str)))))
