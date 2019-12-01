;;; ~/.doom.d/custom/+org.el -*- lexical-binding: t; -*-

;;
;; Org-mode
(after! org
  (setq
   outline-blank-line nil
   org-cycle-separator-lines 2
   org-log-done 'time
   org-directory "~/OneDrive/org"
   org-agenda-files '("~/OneDrive/org" "~/OneDrive/org/brain")
   org-latex-caption-above nil
   org-agenda-skip-scheduled-if-done t
   org-ellipsis " ▾ "
   org-bullets-bullet-list '("·")
   org-tags-column -80
   org-refile-targets (quote ((nil :maxlevel . 1))))
  ;; Org-links to emails
  )
;; Hooks
;; (add-hook 'org-mode-hook (lambda ()
;;                            (hl-line-mode -1)))
(add-hook 'org-mode-hook (lambda ()
            (flycheck-mode -1)))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
(add-hook 'org-mode-hook #'doom-disable-line-numbers-h)
(add-hook 'org-mode-hook #'auto-fill-mode)
;; (add-hook! 'org-mode-hook (company-mode -1))
;;
(add-hook! 'org-capture-mode-hook (company-mode -1))

;;
;; Notes
(def-package! org-noter
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
;; Blog
(def-package! ox-hugo
  :defer t
  :after ox)

;;
;; Jira
(def-package! org-jira
  :defer t
  :config
  ;; Fix access
  (setq jiralib-url "https://jira.zenuity.com"
        org-jira-users `("Niklas Carlsson" . ,(shell-command-to-string "printf %s \"$(pass show work/zenuity/login | sed -n 2p | awk '{print $2}')\""))
        jiralib-token `("Cookie". ,(my/init-jira-cookie)))
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

;;
;; Org Capture
(setq
 org-capture-templates '(("x" "Note" entry
                          (file+olp+datetree "journal.org")
                          "**** [ ] %U %?" :prepend t :kill-buffer t)
                         ("t" "Task" entry
                          (file+headline "tasks.org" "Inbox")
                          "* [ ] %?\n%i" :prepend t :kill-buffer t))
 +org-capture-todo-file "tasks.org")

;;
;; Org UI Setting
(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  ;; (map! :map org-mode-map
  ;;       :n 'M-j #'org-metadown
  ;;       :n 'M-k #'org-metaup)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

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
(after! org
  (setq org-tag-alist (quote ((:startgroup)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

;; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;;
;; To-do settings
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d@/!)")
              (sequence "PROJECT(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "WAITING(w@/!)" "DELEGATED(e!)" "HOLD(h)" "|" "CANCELLED(c@/!)" "PHONE" "MEETHING")
              (sequence "SOMEDAY" "READING" "|" "DONE")))
      org-todo-repeat-to-state "NEXT")

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "#BE616F" :weight bold)
              ("NEXT" :inherit warning)
              ("PROJECT" :foreground "#3ab8a2" :weight bold)
              ("WAITING" :foreground "#c9dcb3" :weight bold)
              ("HOLD" :foreground "#c6ca53" :weight bold)
              ("CANCELLED" :foreground "#5f6062" :weight bold)
              ("MEETING" :foreground "#ffcf9c" :weight bold)
              ("PHONE" :foreground "#d17b0f" :weight bold)
              ("SOMEDAY":foreground "#D88373" :weight bold)
              ("READING":foreground "#86BA90" :weight bold))))

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
)


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
   org-clock-in-switch-to-state 'bh/clock-in-to-next
   ;; Change tasks to TODO when clocking out
   org-clock-out-switch-to-state 'bh/clock-out-to-pre
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
