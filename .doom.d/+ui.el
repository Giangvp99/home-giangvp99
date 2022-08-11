;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq-default fill-column 120
              delete-trailing-lines t)

;; Delete the selection when pasting
(delete-selection-mode 1)

(defvar my-base-font-size (if (<= (display-pixel-height) 1080)
                              10.0 11.0))

;; Use float for size as it indicates point size rather then pixels (better scaling)
(setq doom-font (font-spec :family "FiraCode Nerd Font" :width 'expanded :size my-base-font-size)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :width 'expanded :size (+ my-base-font-size 5))
      doom-serif-font (font-spec :family "FiraCode Nerd Font" :width 'expanded :size my-base-font-size)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size my-base-font-size))
