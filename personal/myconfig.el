;;设置字体
(set-frame-font "monaco-11")
;;关闭whitespace

(menu-bar-mode 1)

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

(setq x-select-enable-clipboard t)
;; 选中或删除即时复制
(delete-selection-mode t)
;; 支持中键粘贴
(setq mouse-yank-at-point t)


;;yasnippet
(require 'yasnippet)
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用



;;auto-complete-clang-async
(require 'auto-complete-clang-async)  
(defun ac-cc-mode-setup ()  
(setq ac-clang-complete-executable "~/.emacs.d/plugin/clang-complete")  
(setq ac-sources '(ac-source-clang-async))  
(ac-clang-launch-completion-process)  
)  

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

;; Add kernel style
(c-add-style "kernel-coding"
             '( "linux"
                (c-basic-offset . 8)
                (indent-tabs-mode . t)
                (tab-width . 8)
                (c-comment-only-line-offset . 0)
                (c-hanging-braces-alist
                 (brace-list-open)
                 (brace-entry-open)
                 (substatement-open after)
                 (block-close . c-snug-do-while)
                 (arglist-cont-nonempty))
                (c-cleanup-list brace-else-brace)
                (c-offsets-alist
                 (statement-block-intro . +)
                 (knr-argdecl-intro . 0)
                 (substatement-open . 0)
                 (substatement-label . 0)
                 (label . 0)
                 (statement-cont . +))
                ))
(c-add-style "my-coding-style"
             '( "k&r"
                (c-basic-offset . 4)
                (indent-tabs-mode . nil)
                (tab-width . 4)
                (c-comment-only-line-offset . 0)
                (c-hanging-braces-alist
                 (brace-list-open)
                 (brace-entry-open)
                 (substatement-open after)
                 (block-close . c-snug-do-while)
                 (arglist-cont-nonempty))
                (c-cleanup-list brace-else-brace)
                (c-offsets-alist
                 (statement-block-intro . +)
                 (knr-argdecl-intro . 0)
                 (substatement-open . 0)
                 (substatement-label . 0)
                 (label . 0)
                 (statement-cont . +))
                ))

(defvar kernel-keywords '("linux" "kernel" "driver")
  "Keywords which are used to indicate this file is kernel code.")

(add-hook 'c-mode-hook
          (lambda ()
            (let* ((filename (buffer-file-name))
                   (is-kernel-code nil))
              (if filename
                  (dolist (keyword kernel-keywords)
                    (if (string-match keyword filename)
                        (setq is-kernel-code t))))
              (if is-kernel-code
                  (c-set-style "kernel-coding")
                (c-set-style "my-coding-style")))))
                
 ;;search          
(defun isearch-cur-word (fun)
  "ISearch current word use function FUN."
  (let ((cur-word (current-word)))
    (if (not cur-word)
        (message "No word under cursor.")
      (call-interactively fun)
      (isearch-yank-string cur-word))))
 
(defun isearch-forward-cur-word (&optional backward)
  "`isearch-forward' current word."
  (interactive "P")
  (let ((fun (if backward 'isearch-backward 'isearch-forward)))
    (isearch-cur-word fun)))
    
(require 'google-c-style)


