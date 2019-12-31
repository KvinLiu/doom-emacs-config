;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :input
       chinese
       ;;japanese

       :completion
       (company           ; the ultimate code completion backend
        ;; +childframe
        +tng)
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       (ivy                             ; a search engine for love and life
        ;; +fuzzy
        +prescient
        +childframe
        +icons)

       :ui
       deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       hydra
       indent-guides     ; highlighted indent columns
       modeline
       ;(modeline
       ;+light)          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ;;neotree         ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       pretty-code       ; replace bits of code with pretty symbols
       ;; tabs           ; an tab bar for Emacs
       treemacs           ; a project drawer, like neotree but cooler
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       (window-select
        +numbers)     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       lispy             ; vim for lisp, for people who dont like vim
       multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired            ; making dired pretty [functional]
        ;; +ranger         ; bringing the goodness of ranger to dired
        +icons
        )
       (ibuffer
        +icons)
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; a consistent, cross-platform shell (WIP)
       ;;shell             ; a terminal REPL for Emacs
       term              ; terminals in Emacs
       ;;vterm             ; another terminals in Emacs

       :tools
       ;;ansible
       debugger          ; stepping through code, to help you add bugs
       ;;direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ein               ; tame Jupyter notebooks with emacs
       (eval
        +overlay)         ; run code, run (also, repls)
       flycheck           ; tasing you for every semicolon you forget
       (flyspell
        +everywhere)          ; tasing you for misspelling mispelling
       gist              ; interacting with github gists
       (lookup           ; helps you navigate your code and documentation
        +dictionary ; Enable word definition and thesaurus lookup functionality.
        +docsets
        )        ; ...or in Dash docsets locally
       lsp
       macos           ; MacOS-specific commands
       magit             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       pass              ; password manager for nerds
       pdf               ; pdf enhancements
       prodigy           ; FIXME managing external services & code builders
       rgb               ; creating color strings
       ;;terraform         ; infrastructure as code
       ;; tmux              ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp
       ;; wakatime

       :lang
       ;;agda              ; types of types of types of types...
       ;;assembly          ; assembly for fun or debugging
       (cc
        +lsp)              ; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data                ; config/data formats
       ;;erlang            ; an elegant language for a more civilized age
       (elixir
        +lsp)              ; erlang done right
       (elm
        +lsp)              ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       ;;ess               ; emacs speaks statistics
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;go                ; the hipster dialect
       ;;(haskell +intero) ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ;
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       (javascript
        +lsp)              ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       (markdown
        +grip)          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org              ; organize your plain life in plain text
        +brain           ; custom attachment system
        +dragndrop       ; file drag & drop support
        ; +ipython
        ; +journal
        ; +gnuplot
        +jupyter         ; ipython/jupyter support for babel
        +pandoc          ; pandoc integration into org's exporter
        +present         ; using Emacs for presentations
        +pomodoro
        +hugo)      

       ;;perl              ; write code no one else can comprehend
       ;;php               ; perl's insecure younger brother
       plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python                          ; beautiful is better than ugly
        ;+pyenv
        +conda
        +lsp)
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       rest                ; Emacs as a REST client
       ;;ruby              ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       (sh
        +fish
        +lsp)              ; she sells {ba,z,fi}sh shells on the C xor
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       (web
        +lsp)              ; the tubes

       :email
       ;;(mu4e +gmail)       ; WIP
       notmuch             ; WIP
       ;;(wanderlust +gmail) ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       ;;calendar
       ;;irc              ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought
       ;;(write            ; emacs as a word processor (latex + org + markdown)
       ;; +wordnut         ; wordnet (wn) search
       ;; +langtool)       ; a proofreader (grammar/style check) for Emacs

       :collab
       ;;floobits          ; peer programming for a price
       ;;impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; config. Use it as a reference for your own modules.
       (default +bindings +smartparens))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272C36" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-safe-themes
   (quote
    ("6cbf6003e137485fb3f904e76fb15bc48abc386540f43f54e2a47a9884e679f6" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" "de43de35da390617a5b3e39b6b27c107cc51271eb95cceb1f43d13d9647c911d" "9d54f3a9cf99c3ffb6ac8e84a89e8ed9b8008286a81ef1dbd48d24ec84efb2f1" "a4b9eeeabde73db909e6b080baf29d629507b44276e17c0c411ed5431faf87dd" "a4fa3280ffa1f2083c5d4dab44a7207f3f7bcb76e720d304bd3bd640f37b4bef" "4a9f595fbffd36fe51d5dd3475860ae8c17447272cf35eb31a00f9595c706050" "a9c619535d63719a15f22e3c450a03062d3fed1e356ef96d33015849c4c43946" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "a2286409934b11f2f3b7d89b1eaebb965fd63bc1e0be1c159c02e396afb893c8" "1728dfd9560bff76a7dc6c3f61e9f4d3e6ef9d017a83a841c117bd9bebe18613" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "071f5702a5445970105be9456a48423a87b8b9cfa4b1f76d15699b29123fb7d8" "2a3ffb7775b2fe3643b179f2046493891b0d1153e57ec74bbe69580b951699ca" "332e009a832c4d18d92b3a9440671873187ca5b73c2a42fbd4fc67ecf0379b8c" default)))
 '(fci-rule-color "#556873")
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
 '(objed-cursor-color "#DF8C8C")
 '(pdf-view-midnight-colors (cons "#FDF6E3" "#556b72"))
 '(vc-annotate-background "#3c4c55")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A8CE93")
    (cons 40 "#b8d293")
    (cons 60 "#c9d693")
    (cons 80 "#DADA93")
    (cons 100 "#e2d291")
    (cons 120 "#eaca90")
    (cons 140 "#F2C38F")
    (cons 160 "#e7b1a0")
    (cons 180 "#dc9fb1")
    (cons 200 "#D18EC2")
    (cons 220 "#d58db0")
    (cons 240 "#da8c9e")
    (cons 260 "#DF8C8C")
    (cons 280 "#c98f92")
    (cons 300 "#b39399")
    (cons 320 "#9e979f")
    (cons 340 "#556873")
    (cons 360 "#556873")))
 '(vc-annotate-very-old-color nil)
 '(wakatime-api-key "fd8c6082-9b71-4459-b755-6d590f74921b")
 '(wakatime-cli-path "wakatime")
 '(which-key-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:foreground "#171717" :weight bold :height 1.5))))
 '(org-done ((t (:background "#E8E8E8" :foreground "#0E0E0E" :strike-through t :weight bold))))
 '(org-headline-done ((t (:foreground "#171717" :strike-through t))))
 '(org-image-actual-width (quote (600)))
 '(org-level-1 ((t (:foreground "#090909" :weight bold :height 1.3))))
 '(org-level-2 ((t (:foreground "#090909" :weight normal :height 1.2))))
 '(org-level-3 ((t (:foreground "#090909" :weight normal :height 1.1))))
 '(variable-pitch ((t (:family "ETBembo")))))
