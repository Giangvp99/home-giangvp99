;; unmap default keys
(map! :leader
      "." nil
      ":" nil
      "c" nil
      )
;; my keys config
(map!
 (:after vterm
  (:map vterm-mode-map
   "M-h" #'windmove-left
   "M-l" #'windmove-right
   "M-k" #'windmove-up
   "M-j" #'windmove-down))
 (:n
  "M-h" #'windmove-left
  "M-l" #'windmove-right
  "M-k" #'windmove-up
  "M-j" #'windmove-down)
 )


(map! :leader
      :desc "Toggle treemacs" :g "e" #'+treemacs/toggle
      :desc "M-x" :g "." #'execute-extended-command

      (:when (featurep! :editor multiple-cursors)
       (:prefix-map ("m" . "multiple-cursors")
        :desc "Edit lines"         "l"         #'mc/edit-lines
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
      )
