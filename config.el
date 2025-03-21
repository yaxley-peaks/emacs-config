;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Yaxley Peaks"
      user-mail-address "yax@yaxley.in")

(setq doom-font (font-spec :family "JetBrains Mono"  :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Inter"  :weight 'normal)
      doom-symbol-font doom-font)

(setq doom-theme 'doom-vibrant)

(setq display-line-numbers-type t)

(map! :localleader :desc "Open treemacs" :n "f" 'treemacs)

(when (display-graphic-p)
  (toggle-frame-maximized))

(setq shell-file-name (executable-find
                       "bash"))
(setq-default vterm-shell
              "/usr/bin/fish")
(setq-default explicit-shell-file-name
              "/usr/bin/fish")

(setq markdown-display-remote-images t)
(require 'dap-cpptools)
(require 'dap-lldb)

(setq org-directory "~/orgs/")
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(defvar yax/is-terminal-open nil)
(defvar yax/open-terminal-window)

(defun yax/open-term ()
  (if (not yax/is-terminal-open)
      (progn
        (setq yax/is-terminal-open t)
        (split-window nil (truncate (/ window-min-height 0.40)) 'above)
        (term "/usr/bin/fish")
        (evil-insert 1)
        (setq yax/open-terminal-window (selected-window)))
    (setq yax/is-terminal-open nil)))

(defun yax/close-term ()
  (if yax/is-terminal-open
      (progn
        (setq yax/is-terminal-open nil)
        (delete-window yax/open-terminal-window)
        (setq yax/open-terminal-window nil))))

(defun yax/toggle-term ()
  (interactive)
  (if yax/is-terminal-open
      (yax/close-term)
    (yax/open-term)))

(map! :desc "Toggle terminal" :ni "C-`" 'yax/toggle-term)

(setq frame-titles-list '("Vim"
                          "Sublime"
                          "Emacs"
                          "Visual Studio Code"
                          "IntelliJ Idea"
                          "Atom"
                          "Brackets"
                          "Dreamweaver"
                          "Notepad"
                          "Wordpad"
                          "XCode"
                          "Builder"))

(defun yax/get-random-element-from-list (lst)
  (let* ((size (length lst))
         (index (random size)))
    (nth index lst)))


(setq frame-title-format
      (concat "%b - "
              (yax/get-random-element-from-list frame-titles-list)))

(defun ascii-banner ()
  (let* ((banner '("⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⠄⠒⠒⠉⠉⠉⠉⠉⠓⠂⠤⢀⠀⠀⠀⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⢀⠄⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⢄⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠀⠀"
                   "⠀⠀⡰⠁⠀⠀⠀⠀⠀⣀⣀⣀⡀⠀⠀⠀⠀⠀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠢⠀⠀"
                   "⠀⡐⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣦⠀⠀⣰⣾⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠱⠀"
                   "⡰⠀⠀⢀⣴⣿⠟⠉⢈⠟⠁⢹⣿⣿⡇⢀⣿⠟⠁⠀⡬⠛⣿⣿⣿⣷⣄⠀⠀⢡"
                   "⡇⠀⣠⣿⡿⠁⠀⠀⢎⠀⢀⣼⣿⣿⡇⢸⠏⠀⠀⠘⠀⣰⣿⣿⣿⣿⣿⣦⠀⢸"
                   "⡇⢠⠃⡿⠁⠀⠀⠀⠀⣷⣿⣿⣿⣿⡿⢸⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡆⢧⢸"
                   "⡇⡞⠀⡇⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⢸⣆⡀⠀⢀⣼⣿⣿⣿⣿⣿⣿⡇⢸⢸"
                   "⡇⢧⠀⢷⣄⣀⣀⣴⣿⣿⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢸⢸"
                   "⢰⠸⡄⠘⣿⡟⠻⣿⣿⣿⣿⣿⣿⡿⠁⠀⢻⣿⡉⠙⣿⣿⣿⣿⣿⣿⡏⠀⡞⡸"
                   "⠀⢂⠹⣄⠘⣧⣠⣾⣿⡿⢿⣣⡿⠁⠀⠀⠀⠻⣿⣿⢿⡿⢟⣾⣿⠏⢀⠜⠠⠁"
                   "⠀⠀⠢⡈⠑⠚⠿⠷⠶⠿⠟⠋⠀⠀⠀⠀⠀⠀⠈⠛⠿⠾⠿⠿⠕⠛⠁⡰⠁⠀"
                   "⠀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠑⠠⡀⠀⠀⠀⠀⠀⠠⠞⠙⠦⠀⠀⠀⠀⠀⢀⡠⠊⠀⠀⠀⠀⠀"
                   "⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠤⢀⣀⣀⣀⣀⣀⣀⣀⡠⠔⠂⠁⠀⠀⠀⠀⠀⠀⠀"))

         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'ascii-banner)

(defun sponge-case-text-in-region (start end)
  (interactive "r")
  (setq sponge-case--temp-boolean t)
  (save-excursion
    (goto-char start)
    (while ( < start end)
      (let ((char (following-char)))
        (delete-char 1)
        (insert-char
         (if (cl-evenp (- end start)) (upcase char) (downcase char))))
      (setq start (1+ start)))))

(defun reverse-text (start end)
  (interactive "r")
  (let* ((text (buffer-substring-no-properties start end))
         (reversed-text (reverse text)))
     (progn
       (delete-region start end)
       (insert reversed-text))))

(defun string-to-words (str)
  (string-split str " " nil))

(defun scramble-word (word)
  (let* ((word-length (length word))
         (first-letter (substring word 0 1))
         (last-letter (substring word (- word-length 1)))
         (rest-of-word (substring word 1 (- word-length 1)))
         (scrambled-letters (concat (sort (append rest-of-word '()) (lambda (a b) (cl-evenp (random)))) "")))
    (concat first-letter scrambled-letters last-letter)))

(defun scramble-words (s) (string-join
                           (mapcar 'scramble-word
                                   (string-to-words s)) " "))

(defun scramble-words-in-region (s e)
  (interactive "r")
  (defun f (x) (scramble-words x))
  (let ((buffer-text (buffer-substring s e)))
    (replace-region-contents s e (lambda ()
                                   ;; call a few times to properly churn
                                   (f (f (f (f buffer-text))))))))

(setq gnus-select-method '(nntp "news.eternal-september.org")
      gnus-read-active-file nil
      gnus-use-trees nil)

(setq gnus-posting-styles
      '((".*"
         (signature "(yaxp me) => t")
         (organization "Not a Noiseless Patient Spider"))))

(defun my-fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply #'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              '()
            secret))
      (error "Password not found for %S" params))))

(defun my-nickserv-password (_)
  (my-fetch-password :user "yax__" :host "irc.libera.chat"))

(after! circe
  (set-irc-server! "irc.libera.chat"
    `(:tls t
      :port 6697
      :nick "yax__"
      :sasl-username "yax__"
      :sasl-password my-nickserv-password
      :channels ("#emacs" "#developersindia")))
  (set-irc-server! "soju1"
    `(:tls t
      :host "vm"
      :port 6697
      :nick "yax"
      :sasl-username "yaxley_peaks"
      :sasl-password "12345678")))

;; IRC stuff
