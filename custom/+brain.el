;;; ~/.doom.d/custom/+brain.el -*- lexical-binding: t; -*-

;;
;; The org brain
(def-package! org-brain
  :commands (org-brain-visualize)
  :init (add-to-list 'evil-motion-state-modes 'org-brain-visualize-mode)
  :config
  (add-hook! org-brain-visualize-mode 'visual-line-mode)
  (set-popup-rule! "*org-brain*" :ignore t)
  (setq org-id-locations-file (concat doom-local-dir ".org-id-locations"))
  (setq org-brain-visualize-default-choices 'all) ; could be set to files for increased performance
  (setq org-brain-title-max-length 20)
  (setq org-brain-refile-max-level 3)   ; max level for refiling
  (push 'org-brain-visualize-mode evil-snipe-disabled-modes)

  ;; define keybindings
  (map!
   :map org-brain-visualize-mode-map
   :m "C-k" #'evil-window-up
   :m "C-j" #'evil-window-down
   :m "C-h" #'evil-window-left
   :m "C-l" #'evil-window-right
   :m "-" (λ! ()
              (org-brain-visualize-remove-grandparent)
              (org-brain-visualize-remove-grandchild))
   :m "=" (λ! ()
              (org-brain-visualize-add-grandparent)
              (org-brain-visualize-add-grandchild))
   (:desc "add" :prefix "a"
     :m "p" #'org-brain-add-parent
     :m "c" #'org-brain-add-child
     :m "f" #'org-brain-add-friendship
     :m "r" #'org-brain-add-resource
     :m "h" #'org-brain-add-child-headline)

   (:desc "set" :prefix "s"
     :m "a" #'org-brain-visualize-attach
     :m "T" #'org-brain-set-title
     :m "t" #'org-brain-set-tags
     :m "f" #'org-brain-rename-file)

   :m "p" #'org-brain-visualize-paste-resource
   :m "R" (λ! (org-brain-stop-wandering) (revert-buffer))
   :m "b" #'org-brain-visualize-back

   (:desc "remove" :prefix "r"
     :m "p" #'org-brain-remove-paren
     :m "c" #'org-brain-remove-child
     :m "f" #'org-brain-remove-friendship)

   (:desc "do" :prefix "d"
     :m "d" #'org-brain-delete-entry
     :m "p" #'org-brain-pin
     :m "a" #'org-brain-archive)

   :m "N" #'org-brain-new-child

   (:desc "view" :prefix "z"
     :m "m" #'org-brain-visualize-mind-map
     :m "b" #'org-brain-visualize-back
     :m "r" #'org-brain-visualize-random
     :m "w" #'org-brain-visualize-wander)
   :m "j" #'forward-button
   :m "k" #'backward-button
   :m "o" #'org-brain-goto-current
   :m "v" #'org-brain-visualize
   :m "q" #'org-brain-visualize-quit))
;;
;; The org brain
(def-package! org-brain
  :commands (org-brain-visualize)
  :init (add-to-list 'evil-motion-state-modes 'org-brain-visualize-mode)
  :config
  (add-hook! org-brain-visualize-mode 'visual-line-mode)
  (set-popup-rule! "*org-brain*" :ignore t)
  (setq org-id-locations-file (concat doom-local-dir ".org-id-locations"))
  (setq org-brain-visualize-default-choices 'all) ; could be set to files for increased performance
  (setq org-brain-title-max-length 20)
  (setq org-brain-refile-max-level 3)   ; max level for refiling
  (push 'org-brain-visualize-mode evil-snipe-disabled-modes)

  ;; define keybindings
  (map!
   :map org-brain-visualize-mode-map
   :m "C-k" #'evil-window-up
   :m "C-j" #'evil-window-down
   :m "C-h" #'evil-window-left
   :m "C-l" #'evil-window-right
   :m "-" (λ! ()
              (org-brain-visualize-remove-grandparent)
              (org-brain-visualize-remove-grandchild))
   :m "=" (λ! ()
              (org-brain-visualize-add-grandparent)
              (org-brain-visualize-add-grandchild))
   (:desc "add" :prefix "a"
     :m "p" #'org-brain-add-parent
     :m "c" #'org-brain-add-child
     :m "f" #'org-brain-add-friendship
     :m "r" #'org-brain-add-resource
     :m "h" #'org-brain-add-child-headline)

   (:desc "set" :prefix "s"
     :m "a" #'org-brain-visualize-attach
     :m "T" #'org-brain-set-title
     :m "t" #'org-brain-set-tags
     :m "f" #'org-brain-rename-file)

   :m "p" #'org-brain-visualize-paste-resource
   :m "R" (λ! (org-brain-stop-wandering) (revert-buffer))
   :m "b" #'org-brain-visualize-back

   (:desc "remove" :prefix "r"
     :m "p" #'org-brain-remove-paren
     :m "c" #'org-brain-remove-child
     :m "f" #'org-brain-remove-friendship)

   (:desc "do" :prefix "d"
     :m "d" #'org-brain-delete-entry
     :m "p" #'org-brain-pin
     :m "a" #'org-brain-archive)

   :m "N" #'org-brain-new-child

   (:desc "view" :prefix "z"
     :m "m" #'org-brain-visualize-mind-map
     :m "b" #'org-brain-visualize-back
     :m "r" #'org-brain-visualize-random
     :m "w" #'org-brain-visualize-wander)
   :m "j" #'forward-button
   :m "k" #'backward-button
   :m "o" #'org-brain-goto-current
   :m "v" #'org-brain-visualize
   :m "q" #'org-brain-visualize-quit))
