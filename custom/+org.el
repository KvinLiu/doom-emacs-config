;;; ~/.doom.d/custom/+org.el -*- lexical-binding: t; -*-


;;; User-Defined Variables

(defvar user-text-directory "~/OneDrive/Text/")
(defvar user-scratchpad-path (concat user-text-directory "scratchpad.txt"))
;; Symlink in my home directory.
(defvar user-org-directory (concat user-text-directory "org/"))

(defvar user-ideas-org (concat user-org-directory "ideas.org"))
(defvar user-notes-org (concat user-org-directory "notes.org"))
(defvar user-physical-org (concat user-org-directory "physical.org"))
(defvar user-projects-org (concat user-org-directory "notes.org"))
(defvar user-todo-org (concat user-org-directory "todo.org"))
(defvar user-work-org (concat user-org-directory "work.org"))

(use-package! org
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ;; ("C-c a" . org-agenda)
         ("C-c b" . org-switchb)
         ("C-c M-k" . org-cut-subtree)
         ("<down>" . org-insert-todo-heading)
         :map org-mode-map
         ("C-c >" . org-time-stamp-inactive))
  :custom-face
  (variable-pitch ((t (:family "ETBembo"))))
  (org-document-title ((t (:foreground "#171717" :weight bold :height 1.5))))
  (org-done ((t (:background "#E8E8E8" :foreground "#0E0E0E" :strike-through t :weight bold))))
  (org-headline-done ((t (:foreground "#171717" :strike-through t))))
  (org-level-1 ((t (:foreground "#090909" :weight bold :height 1.3))))
  (org-level-2 ((t (:foreground "#090909" :weight normal :height 1.2))))
  (org-level-3 ((t (:foreground "#090909" :weight normal :height 1.1))))
  (org-image-actual-width '(600))
  :config
  (setq org-directory user-org-directory
        ;; Agenda Sttings
        org-agenda-files (list
                          user-todo-org
                          user-work-org)
        org-agenda-block-separator ""
        org-agenda-skip-scheduled-if-done t

        org-catch-invisible-edits 'smart
        ;; All subtasks must Done before markgin a task as Done.
        org-enforce-todo-dependencies t
        ;; Log time a task was set to Done
        org-log-done 'time
        ;; Prefer rescheduling to future dates and times.
        org-read-date-prefer-future 'time
        ;; Should ‘org-insert-heading’ leave a blank line before new heading/item?
        org-blank-before-new-entry '((heading . nil) (plain-list-item . nil))
        org-startup-indented t
        org-startup-truncated nil
        org-startup-with-inline-images t
        org-imenu-depth 5
        org-outline-path-complete-in-steps nil
        org-src-fontify-natively t
        org-lowest-priority ?C
        org-default-priority ?B
        org-yank-adjusted-subtrees t
        org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "SOMEDAY(.)" "MAYBE(m)" "|" "DONE(x!)" "CANCELLED(c)")
          (sequence "TODAY(T)" "|" "DONE(x!)" "CANCELLED(c)"))

        ;; Org-refile settings
        ;; refile notes to the top of the list
        org-reverse-note-order t
        ;; Use head line paths (level1/level2/...)
        org-refile-use-outline-path t
        ;; Go down in steps when completing a path.
        org-outline-path-complete-in-steps nil
        org-refile-targets
        '((org-agenda-files . (:maxlevel . 99))
          (user-notes-org . (:maxlevel . 99))
          (user-work-org . (:maxlevel . 99))
          (user-ideas-org . (:maxlevel . 99))
          (user-projects-org . (:maxlevel . 99)))

        ;; Theming
        org-ellipsis "  " ;; folding symbol
        org-bullets-bullet-list '("·")
        org-fancy-priorities-list '("⚡" "⬆" "☕")
        org-pretty-entities t
        org-hide-emphasis-markers t ;; show actually italicized text instead of /italicized text/
        outline-blank-line nil
        org-cycle-separator-lines 2
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t)

  (add-to-list 'org-global-properties
               '("Effort_ALL". "0:05 0:15 0:30 1:00 2:00 3:00 4:00"))
  )
;; Org-mode
;; (after! org
;; setq

;;    org-ellipsis " ▾ "
;;    org-bullets-bullet-list '("·")
;;   )


;;
;; Hooks
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
(add-hook 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook 'org-mode-hook
          '(lambda ()
             (setq line-spacing 0.3) ;; Add more line padding for readability
             (variable-pitch-mode 1) ;; All fonts with variable pitch.
             (mapc
              (lambda (face) ;; Other fonts with fixed-pitch.
                (set-face-attribute face nil :inherit 'fixed-pitch))
              (list 'org-code
                    'org-link
                    'org-block
                    'org-table
                    'org-verbatim
                    'org-block-begin-line
                    'org-block-end-line
                    'org-meta-line
                    'org-document-info-keyword))
             )
          )
(add-hook! 'org
           '(lambda () (flycheck-mode -1))
           #'auto-fill-mode
           )

(add-hook! 'org-capture-mode-hook (company-mode -1))

;;
;; Notes
(use-package! org-noter
  :after org
  :config
  (setq org-noter-always-create-frame nil
        org-noter-auto-save-last-location t)
  (map! :localleader
        :map org-mode-map
        (:prefix-map ("n" . "org-noter")
          :desc "Open org-noter" :n "o" #'org-noter
          :desc "Kill org-noter session" :n "k" #'org-noter-kill-session
          :desc "Insert org-note" :n "i" #'org-noter-insert-note
          :desc "Insert precise org-note" :n "p" #'org-noter-insert-precise-note
          :desc "Sync current note" :n "." #'org-noter-sync-current-note
          :desc "Sync next note" :n "]" #'org-noter-sync-next-note
          :desc "Sync previous note" :n "[" #'org-noter-sync-prev-note)))


;;
;; Jira
(use-package! org-jira
  :defer t
  :config
  ;; Fix access
  ;; (setq jiralib-url "https://jira.zenuity.com"
  ;;       org-jira-users `("Niklas Carlsson" . ,(shell-command-to-string "printf %s \"$(pass show work/zenuity/login | sed -n 2p | awk '{print $2}')\""))
  ;;       jiralib-token `("Cookie". ,(my/init-jira-cookie)))
  ;; Customization jira query
  (setq org-jira-custom-jqls
        '(
          (:jql " project = DUDE AND issuetype = Sub-task AND sprint in openSprints() AND sprint NOT IN futureSprints()"
                :limit 50
                :filename "dude-current-sprint-sub-tasks")
          (:jql " project = DUDE AND assignee = currentuser() order by created DESC "
                :limit 20
                :filename "dude-niklas")
          ))
  ;; Customize the flow
  (defconst org-jira-progress-issue-flow
    '(("To Do" . "In Progress")
      ("In Progress" . "Review")
      ("Review" . "Done"))))

(defun +org*update-cookies ()
  (when (and buffer-file-name (file-exists-p buffer-file-name))
    (let (org-hierarchical-todo-statistics)
      (org-update-parent-todo-statistics))))

(advice-add #'+org|update-cookies :override #'+org*update-cookies)

;; The first two rules already set in config.el Windows (not the operating system)
;; (set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
;; (set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

;;
;; Org Tags

                                        ; Tags with fast selection keys
;; (after! org
;;   (setq org-tag-alist ('((:startgroup)
;;                         ("@office" . ?o)
;;                         ("@home" . ?H)
;;                         (:endgroup)
;;                         ("WAITING" . ?w)
;;                         ("HOLD" . ?h)
;;                         ("PERSONAL" . ?P)
;;                         ("WORK" . ?W)
;;                         ("ORG" . ?O)
;;                         ("NORANG" . ?N)
;;                         ("NOTE" . ?n)
;;                         ("CANCELLED" . ?c)
;;                         ("FLAGGED" . ??))))

;; ;; Allow setting single tags without the menu
;; (setq org-fast-tag-selection-single-key (quote expert))

;; ;; For tag searches ignore tasks with scheduled and deadline dates
;; (setq org-agenda-tags-todo-honor-ignore-options t)

;; ;;
;; ;; To-do settings
;; (setq org-todo-keywords
;;       ('((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d@/!)")
;;          (sequence "PROJECT(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;          (sequence "WAITING(w@/!)" "DELEGATED(e!)" "HOLD(h)" "|" "CANCELLED(c@/!)" "PHONE" "MEETHING")
;;          (sequence "SOMEDAY" "READING" "|" "DONE")))
;;       org-todo-repeat-to-state "NEXT")

;; (setq org-todo-keyword-faces
;;       ('(("TODO" :foreground "#BE616F" :weight bold)
;;          ("NEXT" :inherit warning)
;;          ("PROJECT" :foreground "#3ab8a2" :weight bold)
;;          ("WAITING" :foreground "#c9dcb3" :weight bold)
;;          ("HOLD" :foreground "#c6ca53" :weight bold)
;;          ("CANCELLED" :foreground "#5f6062" :weight bold)
;;          ("MEETING" :foreground "#ffcf9c" :weight bold)
;;          ("PHONE" :foreground "#d17b0f" :weight bold)
;;          ("SOMEDAY":foreground "#D88373" :weight bold)
;;          ("READING":foreground "#86BA90" :weight bold))))

;; (setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; ;; (setq org-todo-state-tags-triggers
;; ;;       (quote (("CANCELLED" ("CANCELLED" . t))
;; ;;               ("WAITING" ("WAITING" . t))
;; ;;               ("HOLD" ("WAITING") ("HOLD" . t))
;; ;;               ("DONE" ("WAITING") ("HOLD"))
;; ;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;; ;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;; ;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
;; )


;;
;; Org Clock
(after! org
  (org-clock-persistence-insinuate)
  (setq
   ;; Save clock data and notes in the LOGBOOK drawer
   org-clock-into-drawer "CLOCKING"
   ;; Show clock sums as hours and minutes, not "n days etc."
   org-time-duration-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)

   ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
   org-clock-history-length 23
   ;; Resume clocking task on clock-in if the clock is open
   org-clock-in-resume t
   ;; Change tasks to Next when clocking in
   ;; org-clock-in-switch-to-state 'bh/clock-in-to-next
   ;; Change tasks to TODO when clocking out
   ;; org-clock-out-switch-to-state 'bh/clock-out-to-pre
   ;; Sometimes I change tasks I'm clocking quickly
   ;; - this removes clocked tasks with 0:00 duration
   org-clock-out-remove-zero-time-clocks t
   ;; Clock out when moving task to a done state
   org-clock-out-when-done t
   ;; Save the running clock and all clock history when existing Emacs, load it
   ;; on start
   org-clock-persist t
   ;; Do not prompt to resume an active clock
   org-clock-persist-query-resume nil
   ;; Enable auto clock resolution for finding open clocks
   org-clock-auto-clock-resolution (quote when-no-clock-is-running)
   ;; Include current clocking task in clock reports
   org-clock-report-include-clocking-task t
   ))
