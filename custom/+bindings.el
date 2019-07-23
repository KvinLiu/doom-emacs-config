;;; ~/.doom.d/custom/+bindings.el -*- lexical-binding: t; -*-

(map! :n "C-h" 'evil-window-left
      :n "C-j" 'evil-window-down
      :n "C-k" 'evil-window-up
      :n "C-l" 'evil-window-right
      ;; editing habits
      :i "C-f" 'forward-char
      :i "C-b" 'backward-char
      :nvi "C-;" 'avy-goto-char-timer

      ;; evilfiy movement
      (:map evil-treemacs-state-map
        "C-h" 'evil-window-left
        "C-l" 'evil-window-right)

      (:map minibuffer-local-map
        "C-n" 'next-line-or-history-element
        "C-p" 'previous-line-or-history-element)

      ;; use ediff for diffing in ranger
      (:map ranger-mode-map
        :nvmei ";=" #'+ora/ediff-files)

      ;; create custom leader bindings
      (:leader
        (:prefix "o"
          :desc "Open debugger" :n "d" #'+dap-hydra/body
          :desc "Open mail" :n "m" #'=notmuch
          :desc "Open visualize brain" :n "v" #'org-brain-visualize)
        ))
