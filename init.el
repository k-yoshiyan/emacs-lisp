;;全画面 
(setq initial-frame-alist 
'((top . 1) (left . 1240) (width . 80) (height . 60)))

;; emacs clientから接続可能にする
(server-start)

;;フォントサイズ
(add-to-list 'default-frame-alist
             '(font . "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1"))

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
