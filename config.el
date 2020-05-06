;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-localleader-key "\\"
      display-line-numbers-type 'relative
      doom-theme 'solarized-dark
      confirm-kill-emacs nil
      )

(map! :after evil
      :mnv "h" 'evil-next-line
      :mnv "j" 'evil-backward-char
      :mnv "," 'evil-ex
      :mnv ";" 'evil-repeat-find-char
      :mnv ":" 'evil-repeat-find-char-reverse
      :mnv "C-n" 'evil-scroll-line-up

      ;:mnv "C-s" 'evil-snipe-s
      ;;:m "C-S" 'evil-snipe-S
      ;:n "s" 'evil-substitute
      :v "s" 'evil-surround-region
      ;:v "S" 'evil-snipe-S

      :map visual-line-mode-map
      :mnv "h" 'evil-next-visual-line
      :mnv "j" 'evil-backward-char

      :leader
      :n "SPC" 'counsel-M-x
      )

(after! evil
  (define-key evil-window-map "h" 'evil-window-down)
  (define-key evil-window-map "H" 'evil-window-move-very-bottom)
  (define-key evil-window-map "j" 'evil-window-left)
  (define-key evil-window-map "J" 'evil-window-move-far-left)

  (setq-default evil-scroll-line-count 3)

  ; Allow cursor to go to top/bottom of screen
  (setq-default smooth-scroll-margin 1)

  (setq-default evil-snipe-smart-case nil)
  )

(after! smartparens
  (setq-default sp-autodelete-closing-pair nil)
  (setq-default sp-autodelete-opening-pair nil))
(add-hook! agda2-mode
  (sp-pair "`" nil :actions :rem)

  ;(cl-loop for (_ . face) in agda2-highlight-faces
  ;      do (if (string-prefix-p "agda2-" (symbol-name face)) ;; Some non-Agda faces are in the list; don't change them
  ;             (unless (equal face 'agda2-highlight-incomplete-pattern-face) ;; Workaround; this face is not defined in recent versions?
  ;             (set-face-attribute face nil
  ;               :box (face-attribute face :background)
  ;               :background 'unspecified))))
  )

(add-hook! agda2-mode
  (setq-default agda2-program-args '("--local-interfaces")))
(map! :after agda2-mode
      :map agda2-mode-map
      :localleader
      "v"   #'agda2-auto-maybe-all
      "n"   #'agda2-compute-normalised-maybe-toplevel
      "SPC" #'agda2-give
      "."   #'agda2-goal-and-context
      ";"   #'agda2-goal-and-context-and-inferred
      ":"   #'agda2-goal-and-context-and-checked
      "t"   #'agda2-goal-type
      "g"   #'agda2-goto-definition-keyboard
      "b"   #'agda2-go-back
      "h"   #'agda2-helper-function-type
      "r"   #'agda2-load
      "c"   #'agda2-make-case
      "o"   #'agda2-module-contents-maybe-toplevel
      "u"   #'agda2-previous-goal
      "y"   #'agda2-next-goal
      "f"   #'agda2-refine
      "z"   #'agda2-search-about-toplevel
      "="   #'agda2-show-constraints
      "e"   #'agda2-show-context
      "?"   #'agda2-show-goals
      "p"   #'agda2-solve-maybe-all
      "s"   #'agda2-why-in-scope-maybe-toplevel
      (:prefix "x"
        "-" #'agda2-comment-dwim-rest-of-buffer
        "c" #'agda2-compile
        "d" #'agda2-remove-annotations
        "h" #'agda2-display-implicit-arguments
        "q" #'agda2-quit
        "r" #'agda2-restart
        )
      )
;(setq-hook! 'agda2-mode-hook comment-line-break-function nil)

(set-popup-rule! "\\*Agda information\\*" :ignore t)

; Maybe fix this for clever placement of *Agda information*:
; (defun my-display-buffer-fn (buffer alist)
;   (if (one-window-p)
;       (display-buffer-in-side-window
;        buffer (cons '(window-side . right) alist))
;     ;; You'd need some more complex logic here to open the window in the
;     ;; bottom-rightmost of the frame:
;     (display-buffer-pop-up-window buffer alist)))
;
; (set-popup-rule! "\\*Agda information\\*" :actions '(my-display-buffer-fn))

;(after! tex
;  (remove-hook! 'TeX-mode-hook #'visual-line-mode))

(after! coq
  (setq-default
   coq-prog-env
   '("COQPATH=/home/james/.nix-profile/lib/coq/8.9/user-contrib/")))
