;; unmap default keys
(map!
 :leader
 "."    nil
 ":"    nil
 "c"    nil
 "<"    nil
 "`"    nil
 ";"    nil
 "*"    nil
 "'"    nil
 "/"    nil
 "RET"  nil
 )
;; my keys config
(map!
 :leader
 :desc "Toggle treemacs" :g "e" #'treemacs
 :desc "M-x" :g "." #'execute-extended-command

 (:when (featurep! :editor multiple-cursors)
  (:prefix ("m" . "multiple-cursors")
   :desc "Edit lines"         "l"         #'mc/edit-linenis
   :desc "Mark next"          "n"         #'mc/mark-next-like-this
   :desc "Unmark next"        "N"         #'mc/unmark-next-like-this
   :desc "Mark previous"      "p"         #'mc/mark-previous-like-this
   :desc "Unmark previous"    "P"         #'mc/unmark-previous-like-this
   :desc "Mark all"           "t"         #'mc/mark-all-like-this
   :desc "Mark all DWIM"      "m"         #'mc/mark-all-like-this-dwim
   :desc "Edit line endings"  "e"         #'mc/edit-ends-of-lines
   :desc "Edit line starts"   "a"         #'mc/edit-beginnings-of-lines
   :desc "Mark tag"           "s"         #'mc/mark-sgml-tag-pair
   :desc "Mark in defun"      "d"         #'mc/mark-all-like-this-in-defun
   :desc "Add cursor w/mouse" "<mouse-1>" #'mc/add-cursor-on-click))

 (:when (featurep! :editor fold)
  (:prefix ("C-f" . "fold")
   "C-d"     #'vimish-fold-delete
   "C-a C-d" #'vimish-fold-delete-all
   "C-f"     #'+fold/toggle
   "C-a C-f" #'+fold/close-all
   "C-u"     #'+fold/open
   "C-a C-u" #'+fold/open-all))
 (:when (featurep! :tools lsp)
  (:prefix ("l"."lsp")
   :desc "format buffer"        "f"     #'+format/buffer))
 )

(map!
 (:after vterm
  (:map vterm-mode-map
   "M-h"        #'windmove-left
   "M-l"        #'windmove-right
   "M-k"        #'windmove-up
   "M-j"        #'windmove-down
   :i "C-SPC"   #'+vterm/toggle))
 (:n
  "M-h"         #'windmove-left
  "M-l"         #'windmove-right
  "M-k"         #'windmove-up
  "M-j"         #'windmove-down
  "C-SPC"       #'+vterm/toggle)
 (:after lsp-mode
  :i "C-j" #'lsp-signature-next
  :i "C-k" #'lsp-signature-previous)
 (:after treemacs-evil
  :map evil-treemacs-state-map
  "a"         #'treemacs-create-file
  "A"         #'treemacs-create-dir
  "r"         #'treemacs-rename
  "R"         #'treemacs-refresh
  "v"         #'treemacs-peek-mode
  "p a"       #'treemacs-add-project-to-workspace
  "p p"       #'treemacs-project
  "p d"       #'treemacs-remove-project-from-workspace
  "p r"       #'treemacs-rename-project
  "w a"       #'treemacs-create-workspace
  "w d"       #'treemacs-remove-workspace
  "w r"       #'treemacs-rename-workspace
  "w s"       #'treemacs-switch-workspace
  "w n"       #'treemacs-next-workspace)

 )
