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
  (require 'org-notmuch))

;; Hooks
(add-hook 'org-mode-hook (lambda ()
                           (hl-line-mode -1)))
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
(add-hook 'org-mode-hook #'doom|disable-line-numbers)
(add-hook 'org-mode-hook #'auto-fill-mode)
;; (add-hook! 'org-mode-hook (company-mode -1))
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
