;;设置字体
(set-frame-font "monaco-11")
;;关闭whitespace


;; color theme

(disable-theme 'zenburn)
(load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
(color-theme-almost-monokai)

;;close whitspcae
(setq prelude-whitespace nil)

;;open evil
(package-initialize)
(evil-mode 1)
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'evil-normal-state)
(key-chord-define-global "jj" nil)
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

;;markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))

;;window numbering
(require 'window-numbering)
(window-numbering-mode 1)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

