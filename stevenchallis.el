;; Personal Information
(setq
 user-full-name "Steve Challis"
 user-mail-address "steve.challis@siriusit.co.uk")

;;
;;
;; Themes
;;
;;

;; Color theme
(color-theme-zenburn)

;;
;;
;; Mail
;;
;;

;; Mail setup
(global-set-key (kbd "C-c m") 'mail)
(setq smtpmail-smtp-server "smtp.siriusit.co.uk")
(setq smtpmail-smtp-service 25)
(setq mail-header-separator "-----")

;;
;;
;; Basics
;;
;;

;; Hide menu/scroll bar by default
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remove margins
;;(set-fringe-style 1)
(fringe-mode -1)

;; Show column and line
(column-number-mode 1)

;; Allow overwrites of selected text
(delete-selection-mode t)

;; Display the time in all modelines
(display-time)

;; Make the y or n suffice for a yes or no question
(fset 'yes-or-no-p 'y-or-n-p) 

;; Clean scratch buffer :)
(setq initial-scratch-message "")

;; Always open *scratch* buffer by default
(setq initial-buffer-choice t)

;; Fill wrap to ~80 chars
;; Use M-q to reformat paragraph
;;(auto-fill-mode 1)
(show-paren-mode 1)

;; Remove annoying black box in the cocoa mac build
(setq visible-bell t)

;; Enable narrowing
(put 'narrow-to-region 'disabled nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Turn off auto wrapping
(toggle-truncate-lines 80)

;; remap M-3 key to a hash (mac keyboards don't have hash displayed)
(global-unset-key (kbd "M-3"))
(global-set-key (kbd "M-3") '(lambda() (interactive) (insert-string "#")))

;; Quick comment/uncomment shortcut
(global-set-key (kbd "C-c =") 'comment-or-uncomment-region)

;; Shortcut for fullscreen (in cocoa emacs)
(global-set-key (kbd "C-c f") 'ns-toggle-fullscreen)

;; Auto indent org files properly without modifying actual structure
(setq org-startup-indented t)

;; More pleasant lisp indentation
(setq lisp-indent-function 'common-lisp-indent-function)

;; Disable prompt when killing a buffer with a process
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Line duplication function and key binding
(defun eemklinks-duplicate-this-line ()
 "Duplicate the current line (without any changes to the kill ring)."
 (interactive)
 (let ((line (buffer-substring (line-beginning-position) (line-end-position))))
   (save-excursion (beginning-of-line) (insert-before-markers line "\n"))))

(global-set-key (kbd "C-c d") 'eemklinks-duplicate-this-line)

;; Buffer/window swapping
;;(require 'buffer-swap)
(defun swap ()
  "Swap windows using buffer-move.el"
  (interactive)
  (if (null (windmove-find-other-window 'right))
      (buf-move-left)
      (buf-move-right)))

;; Rainbow parens
(require 'rainbow-delimiters)

;;
;;
;; Whitespace mode
;;
;;

(setq whitespace-style '(trailing lines-tail space-before-tab face indentation space-after-tab))

(global-set-key (kbd "C-c w") 'whitespace-mode)
;;(global-unset-key (kbd "C-c C-w"))
(global-set-key (kbd "C-c u") 'whitespace-cleanup)

;;
;;
;; YAsnippet
;;
;;

(require 'yasnippet)
(setq yas/trigger-key (kbd "\C-c j"))
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/dropdown-prompt
                             yas/completing-prompt))

;;
;;
;; Session management
;;
;;

;; Save cursor positions after restart
(require 'saveplace)
(setq save-place-file "~/.emacs.d/cursor-places")
(setq-default save-place t)

;; Save buffers after restart
;;(desktop-save-mode 1)

;;
;;
;; Org mode
;;
;;

;; Configure org directories
(setq org-directory "~/Dropbox/org/")

;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/mobile-org/")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull (concat org-mobile-directory "notes.org"))

;; Idle timeout value for org-clock timetracking
(setq org-clock-idle-time 15)

;; todo subheading shortcut
(global-set-key (kbd "C-c s") 'org-insert-todo-subheading)

;; Always want these files open on startup
(find-file (concat org-directory "/notes.org"))
(find-file (concat org-directory "/snippets.org"))
(find-file (concat org-directory "/gtd.org"))

;; Org templates for quick capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" checkitem
	 (file+headline "~/org/gtd.org" "Incoming")
         "- [ ] %?" :prepend t)
        ("m" "Multi Todo" checkitem
	 (file+headline "~/org/gtd.org" "Incoming")
         "- [ ] [0/1] %?\n  - [ ]" :prepend t)
        ("c" "Conversation" entry
	 (file+headline "~/org/gtd.org" "Conversations")
         "* %?" :prepend t)
        ("s" "Short-Term Goal" entry
	 (file+headline "~/org/goals.org" "Short Term") "* %?")
        ("m" "Medium-Term Goal" entry
	 (file+headline "~/org/goals.org" "Medium Term") "* %?")
        ("l" "Long-Term Goal" entry
	 (file+headline "~/org/goals.org" "Long Term") "* %?")))

;;
;;
;; Terminals
;;
;;

;; Custom keybing for opening new multi-term
(global-set-key (kbd "C-x C-t") 'multi-term)

;; List of keys which emacs keeps for itself
;; Default: ("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>")
(setq term-unbind-key-list '("C-z" "C-x" "C-c" "s-v"))

;; List of keys and functions for our use
(setq term-bind-key-alist   '(("C-c C-c" . term-interrupt-subjob)
			      ("C-c C-j" . term-line-mode)
			      ("C-c C-k" . term-char-mode)
			      ("C-c C-p" . term-previous-input)
			      ("C-c C-n" . term-next-input)
			      ("M-p" . previous-line)
			      ("M-n" . next-line)
			      ("M-s" . isearch-forward)
			      ("M-r" . isearch-backward)
			      ("C-m" . term-send-raw)
			      ("C-y" . term-paste)
                              ("s-v" . term-paste)
			      ("M-f" . term-send-forward-word)
			      ("M-b" . term-send-backward-word)
			      ("M-o" . term-send-backspace)
			      ("C-p" . term-send-up)
			      ("C-n" . term-send-down)
			      ("M-d" . term-send-forward-kill-word)
			      ("C-w" . term-send-backward-kill-word)
			      ("C-r" . term-send-reverse-search-history)
			      ("M-," . term-send-input)
			      ("M-." . comint-dynamic-complete)))

;;
;;
;; Tramp
;;
;;

;; Allow LDAP w/sudo to any ^v.* server
(set-default 'tramp-default-proxies-alist
             '((".*.mcr1.gradwell.com" "\\`root\\'" "/ssh:steve.challis@%h:")
               ("sandbox" "\\`root\\'" "/ssh:sandbox@%h:")))

;;
;;
;; Flymake
;;
;;

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Underline errors
(custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))

;; Quickly show next error
(defun my-flymake-show-next-error ()
    (interactive)
    (flymake-goto-next-error)
    (flymake-display-err-menu-for-current-line))

;; Show errors in the modeline to save having to hover over the error
(defun my-flymake-show-help ()
  (interactive)
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

;;
;;
;; Programming
;;
;;

;; Use STK for scheme
(setq scheme-program-name "stk-simply -no-tk")

;; Set default lisp
(setq inferior-lisp-program "sbcl"
      slime-complete-symbol-function 'slime-complete-symbol*)

;;
;;
;; Slime
;;
;;

(add-to-list 'load-path "~/Documents/repos/slime/")
(add-to-list 'load-path "~/Documents/repos/slime/contrib")
(require 'slime)
;;(slime-setup '(slime-repl))
;; 1337 version
(slime-setup '(slime-fancy))

;;
;;
;; Chicken Scheme
;;
;;

(add-to-list 'load-path "/usr/local/lib/chicken/5")
(autoload 'chicken-slime "chicken-slime" "SWANK backend for Chicken" t)
(add-hook 'scheme-mode-hook (lambda () (slime-mode t)))

;;
;;
;; Clojure
;;
;;

(add-hook 'clojure-mode-hook
          (lambda ()
            (slime-mode t)
            (rainbow-delimiters-mode)))

;;
;; Work around autodoc breakage with Clojure
;;

(add-hook 'clojure-mode-hook
         (lambda ()
           (slime-autodoc-mode 0)))

(add-hook 'slime-connected-hook
         (lambda ()
           (if (string= (slime-lisp-implementation-type) "Clojure")
               (setq slime-use-autodoc-mode nil)
             (setq slime-use-autodoc-mode t))))

(add-hook 'slime-mode-hook
         (lambda ()
           (if (eq major-mode 'clojure-mode)
               (slime-autodoc-mode 0)
             (slime-autodoc-mode 1))))

(add-hook 'slime-repl-mode-hook
         (lambda ()
           (if (string= (slime-lisp-implementation-type) "Clojure")
               (progn (setq slime-use-autodoc-mode nil)
                      (slime-autodoc-mode 0))
             (progn (setq slime-use-autodoc-mode t)
                    (slime-autodoc-mode 1)))))


;;
;;
;; HTML
;;
;;

(add-hook 'html-mode-hook
          (lambda ()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)
            (setq tab-width 4)
            (auto-fill-mode -1)
            (message "HTMLMODE")))

;;
;;
;; Javascript
;;
;;

(add-hook 'javascript-mode-hook
          (lambda ()
            (setq js-indent-level 4)
            (setq require-final-newline -1)))

;;
;;
;; Python
;;
;;

(global-set-key (kbd "C-x p") 'py-shell)

(require 'auto-complete)
(add-hook 'python-mode-hook
          (lambda ()
            (turn-on-eldoc-mode)
            (flymake-mode 1)
            (whitespace-mode)
            (auto-complete-mode)
            (setq ac-sources '(ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols))))

;;
;;
;; Custom functions
;;
;;

(defun save-kbd-macro (name)
     "Take a name as argument and save the last defined macro under
        this name at the end of ~/.emacs.d/saved-kb-macros.el"
     (interactive "Name of the macro: ")  ; ask for the name of the macro
     (kmacro-name-last-macro name)         ; use this name for the macro
     (find-file "~/.emacs.d/saved-kb-macros.el")
     (goto-char (point-max))               ; go to the end of the file
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro
     (newline)                             ; insert a newline
     (save-buffer)                         ; save the edited buffer
     (switch-to-buffer nil))               ; return to the initial buffer

;;
;;
;; Packages
;;
;;

;; (slime-setup '(slime-repl))
;; (setq slime-lisp-implementations
;;                                        '((sbcl ("sbcl" "--core" "/Users/stevechallis/sbcl/sbcl.core-for-slime")
;;                                           :init (lambda (port-file _)
;;                                                   (format "(swank:start-server %S)\n" port-file)))
;;                                          (clojure ("clj"))))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(require 'el-get)
(setq el-get-sources '(clojure-mode session sicp 
                       (:name zencoding-mode
                        :after (lambda ()
                                 (require 'zencoding-mode)
                                 (global-set-key (kbd "C-c z") 'zencoding-expand-line)))
                       (:name multi-term 
                        :after (lambda () 
                                 (setq multi-term-program "/bin/bash")
                                 (global-set-key (kbd "C-x t") 'multi-term-next)))))
(el-get 'sync)

;;
;;
;; ERC/IRC
;;
;;

(erc-autojoin-mode t)
 (setq erc-autojoin-channels-alist
       '((".*" "#zonza" "#banter")))


;; (defun erc-start-or-switch ()
;;   "Connect to ERC, or switch to last active buffer"
;;   (interactive)
;;   (if (get-buffer "dev-hson-1:6667") ;; ERC already active?
;;     (erc-track-switch-buffer 1) ;; yes: switch to last active
;;     (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
(defun start-erc ()
  (interactive)
  (erc :server "dev-hson-1" :port 6667 :nick "schallis" :full-name "Steve Challis"))

(start-erc)

(global-set-key (kbd "C-c i") '(lambda() (interactive) (erc-iswitchb)))

;; Show private messages in pop up buffer
(setq erc-auto-query 'buffer)

;; Highlight references to myself
(require 'erc-match)
(setq erc-keywords '("resolve" "schallis" "challis" "steve"))

(message "Steve config enabled")
(provide 'stevechallis)
