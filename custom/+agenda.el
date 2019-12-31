;;; ~/.doom.d/custom/+agenda.el -*- lexical-binding: t; -*-

;;
;; Org agenda Custimize
(use-package org-agenda
  :ensure nil
  :hook (org-agenda-mode . visual-line-mode)
  :bind (
         ("C-c a" . org-agenda-list)
         :map org-agenda-mode-map
         ("M" . org-agenda-bulk-mark-all)
         )

  :config
  ;; Set default span of agenda view.
  (setq org-agenda-span 'day)

  ;; Show scheduled items in order from most to least recent.
  (setq org-agenda-sorting-strategy
        '((agenda habit-down time-up scheduled-down priority-down category-keep)
          (todo   priority-down category-keep)
          (tags   priority-down category-keep)
          (search category-keep)))

  ;; Customize columns (remove filename/category, mostly redundant).
  (setq org-agenda-prefix-format '((agenda . " %i %?-12t% s")
                                   (todo . " %i %-12:c")
                                   (tags . " %i %-12:c")
                                   (search . " %i %-12:c")))

  (setq
   ;; Stop org-agenda from messing up my windows!!
   org-agenda-window-setup 'current-window
   ;; Start org-agenda from the current day.
   org-agenda-start-on-weekday nil
   org-agenda-start-day "0d"
   ;; Don't align tags in the org-agenda (sometimes it messes up the display).
   org-agenda-tags-column 0)

  (defun org-agenda-refresh ()
    "Refresh all `org-agenda' buffers."
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (derived-mode-p 'org-agenda-mode)
          (org-agenda-maybe-redo)
          ))))

  ;; Refresh org-agenda after changing an item status.
  ;; (add-hook 'org-trigger-hook 'org-agenda-refresh)
  ;; Refresh org-agenda after rescheduling a task.
  (defadvice org-schedule (after refresh-agenda activate)
    "Refresh `org-agenda'."
    (org-agenda-refresh))

  ;; Refresh org-agenda after an org-capture.
  (add-hook 'org-capture-after-finalize-hook 'org-agenda-refresh)
  ;; ;; Refresh org-agenda on a timer (refreshes the agenda on a new day).
  ;; (run-with-idle-timer 5 t 'org-agenda-refresh)

  ;; Try to fix the annoying tendency of this function to scroll the point to some
  ;; random place and mess up my view of the agenda.
  ;; NOTE: This is a copy-paste of the original `org-agenda-redo` function,
  ;; with one line commented out.
  (defun org-agenda-redo (&optional all)
    "Rebuild possibly ALL agenda view(s) in the current buffer."
    (interactive "P")
    (let* ((p (or (and (looking-at "\\'") (1- (point))) (point)))
           (cpa (unless (eq all t) current-prefix-arg))
           (org-agenda-doing-sticky-redo org-agenda-sticky)
           (org-agenda-sticky nil)
           (org-agenda-buffer-name (or org-agenda-this-buffer-name
                                       org-agenda-buffer-name))
           (org-agenda-keep-modes t)
           (tag-filter org-agenda-tag-filter)
           (tag-preset (get 'org-agenda-tag-filter :preset-filter))
           (top-hl-filter org-agenda-top-headline-filter)
           (cat-filter org-agenda-category-filter)
           (cat-preset (get 'org-agenda-category-filter :preset-filter))
           (re-filter org-agenda-regexp-filter)
           (re-preset (get 'org-agenda-regexp-filter :preset-filter))
           (effort-filter org-agenda-effort-filter)
           (effort-preset (get 'org-agenda-effort-filter :preset-filter))
           (cols org-agenda-columns-active)
           (line (org-current-line))
           ;; (window-line (- line (org-current-line (window-start))))
           (lprops (get 'org-agenda-redo-command 'org-lprops))
           (redo-cmd (get-text-property p 'org-redo-cmd))
           (last-args (get-text-property p 'org-last-args))
           (org-agenda-overriding-cmd (get-text-property p 'org-series-cmd))
           (org-agenda-overriding-cmd-arguments
            (unless (eq all t)
              (cond ((listp last-args)
                     (cons (or cpa (car last-args)) (cdr last-args)))
                    ((stringp last-args)
                     last-args))))
           (series-redo-cmd (get-text-property p 'org-series-redo-cmd)))
      (put 'org-agenda-tag-filter :preset-filter nil)
      (put 'org-agenda-category-filter :preset-filter nil)
      (put 'org-agenda-regexp-filter :preset-filter nil)
      (put 'org-agenda-effort-filter :preset-filter nil)
      (and cols (org-columns-quit))
      (message "Rebuilding agenda buffer...")
      (if series-redo-cmd
          (eval series-redo-cmd)
        (org-let lprops redo-cmd))
      (setq org-agenda-undo-list nil
            org-agenda-pending-undo-list nil
            org-agenda-tag-filter tag-filter
            org-agenda-category-filter cat-filter
            org-agenda-regexp-filter re-filter
            org-agenda-effort-filter effort-filter
            org-agenda-top-headline-filter top-hl-filter)
      (message "Rebuilding agenda buffer...done")
      (put 'org-agenda-tag-filter :preset-filter tag-preset)
      (put 'org-agenda-category-filter :preset-filter cat-preset)
      (put 'org-agenda-regexp-filter :preset-filter re-preset)
      (put 'org-agenda-effort-filter :preset-filter effort-preset)
      (let ((tag (or tag-filter tag-preset))
            (cat (or cat-filter cat-preset))
            (effort (or effort-filter effort-preset))
            (re (or re-filter re-preset)))
        (when tag (org-agenda-filter-apply tag 'tag t))
        (when cat (org-agenda-filter-apply cat 'category))
        (when effort (org-agenda-filter-apply effort 'effort))
        (when re  (org-agenda-filter-apply re 'regexp)))
      (and top-hl-filter (org-agenda-filter-top-headline-apply top-hl-filter))
      (and cols (called-interactively-p 'any) (org-agenda-columns))
      (org-goto-line line)
      ;; Commenting out the following line stops the random scrolling.
      ;; (recenter window-line)
      ))
  )

;; Recurring org-mode tasks.
(use-package! org-recur
  :after org
  :bind (
         :map org-recur-mode-map

         ("C-c d" . org-recur-finish)
         ("C-c 0" . org-recur-schedule-today)
         ("C-c 1" . org-recur-schedule-1)
         ("C-c 2" . org-recur-schedule-2)

         :map org-recur-agenda-mode-map

         ;; Rebind the 'd' key in org-agenda (default: `org-agenda-day-view').
         ("d" . org-recur-finish)
         ("0" . org-recur-schedule-today)
         ("1" . org-recur-schedule-1)
         ("2" . org-recur-schedule-2)
         ("C-c d" . org-recur-finish)
         ("C-c 0" . org-recur-schedule-today)
         ("C-c 1" . org-recur-schedule-1)
         ("C-c 2" . org-recur-schedule-2)
         )
  :hook ((org-mode . org-recur-mode)
         (org-agenda-mode . org-recur-agenda-mode))
  :demand t
  :config
  (defun org-recur-schedule-1 ()
    (interactive)
    (org-recur-schedule-date "|+1|"))
  (defun org-recur-schedule-2 ()
    (interactive)
    (org-recur-schedule-date "|+2|"))

  (setq org-recur-finish-done t
        org-recur-finish-archive t)
  )

;; Display groups in org-agenda to make things a bit more organized.
(use-package org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode)

  (setq
   org-super-agenda-header-separator ""
   org-super-agenda-unmatched-name "Other"
   org-super-agenda-groups
   '(
     ;; Each group has an implicit OR operator between its selectors.
     (:name "Today"  ; Optionally specify section name
            :time-grid t  ; Items that appear on the time grid.
            :todo "TODAY"   ; Items that have this todo keyword.
            )
     (:name "Work"
            :category "work"
            :tag "work"
            )
     (:name "High Priority"
            :priority "A"
            :order 1
            )
     (:name "Physical"
            :category "physical"
            :tag "physical"
            :order 2
            )
     (:name "Shopping List"
            :category "shopping"
            :tag "shopping"
            :order 3
            )
     (:name "Cleaning"
            :category "cleaning"
            :tag "cleaning"
            :order 4
            )
     (:name "Hygiene"
            :category "hygiene"
            :tag "hygiene"
            :order 5
            )
     (:name "Health"
            :category "health"
            :tag "health"
            :order 6
            )
     (:name "Financial"
            :category "financial"
            :tag "financial"
            :order 7
            )

     ;; After the last group, the agenda will display items that didn't
     ;; match any of these groups, with the default order position of 99

     (:name "Tech"
            :category "tech"
            :tag "tech"
            :order 180
            )
     (:name "To Read"
            :category "read"
            :tag "read"
            :order 181
            )
     (:name "To Watch"
            :category "watch"
            :tag "watch"
            :order 182
            )
     (:todo "WAITING" :order 190)
     ;; (:name "Low priority"
     ;;        :priority "C"
     ;;        :order 200)
     )))

;; Org-Tags
(setq org-tag-alist '(
                      ;; Depth
                      ("@immersive" . ?i) ;; "Deep"
                      ("@process" . ?p)   ;; "Shallow"
                      ;; Context
                      ("@work" . ?w)
                      ("@home" . ?h)
                      ("@errand" . ?e)
                      ;; Time
                      ("15min" . ?<)
                      ("30min" . ?=)
                      ("1h" . ?>)
                      ;; Energy
                      ("Challenge" . ?1)
                      ("Average" . ?2)
                      ("Easy" . ?3)
                      ;; Tags
                      ("tech" . ?t)
                      ("read" . ?r)
                      ("watch" . ?a)
                      ("health" . ?H)
                      ("financial" . ?f)
                      )
      )
;;
;; Org Capture
;; (after! org
;;   (add-to-list 'org-capture-templates
;;                '(("x" "Note" entry
;;                   (file+olp+datetree "journal.org")
;;                   "**** [ ] %U %?" :prepend t :kill-buffer t)
;;                  ("t" "Task" entry
;;                   (file+headline "tasks.org" "Inbox")
;;                   "* [ ] %?\n%i" :prepend t :kill-buffer t))))

;;
;; Reviews
;;

(defun my-new-daily-review ()
  (interactive)
  (let ((org-capture-templates
         '(("d" "Review: Daily Review" entry (file+olp+datetree "~/OneDrive/Text/org/reivews.org")
            (file "~/OneDrive/Text/org/templates/dailyreviewtemplate.org")))))
    (progn
      (org-capture nil "d")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-weekly-review ()
  (interactive)
  (let ((org-capture-templates
         '(("w" "Review: Weekly Review" entry (file+olp+datetree "~/OneDrive/Text/org/reivews.org")
            (file "~/OneDrive/Text/org/templates/weeklyreviewtemplate.org")))))
    (progn
      (org-capture nil "w")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-monthly-review ()
  (interactive)
  (let ((org-capture-templates
         '(("m" "Review: Monthly Review" entry (file+olp+datetree "~/OneDrive/Text/org/reivews.org")
            (file "~/OneDrive/Text/org/templates/monthlyreviewtemplate.org")))))
    (progn
      (org-capture nil "m")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(bind-keys :prefix-map review-map
           :prefix "C-c r"
           ("d" . my-new-daily-review)
           ("w" . my-new-weekly-review)
           ("m" . my-new-monthly-review))
