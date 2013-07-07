;;; License

;; This software is licensed under the CC0 1.0 Public Domain Declaration, as
;; released by Creative Commons <http://creativecommons.org/publicdomain/zero/1.0/>.
;; This software comes with NO WARRANTIES OR GUARANTEES WHATSOEVER.


;;; Misc library called by lalopmak-evil.

(defvar lalopmak-evil-hintstring "Hints for lalop's colemak-evil configuration.  Accessed via: :hints, :h, :ars, or M-x lalopmak-evil-hints.

To dismiss: retype one of the above commands or press q in the buffer.

Normal mode:
+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
|~ Case     |! ExtFlt>  |@ PlyMcr·  |#  <-=     |$  ->|     |% GoMatch  |^  <--     |+ Next<--  |[ Rep :s   |]  =->     |( |<-Sent  |) Sent->|  |_ LastLin  |
|` Go Mk·   |1          |2          |3          |4          |5          |6          |= Format>  |7          |8          |9          |0  |<-     |- TopLine  |
+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
|           |           |           | Jump Line |           |           |           |           |           | PasteAbove|           |           |           |
|  NextTab  |           | WinCmd    | Jump Char |ChangeToEOL| Abort Cmd |           |  ▲        |   WORD    |  ▲  ScrlUp|   WORD    |           |  GoMk·|<  |
| <TAB>     |  RepState |JmpCharTill|JmpNbyChTil|Subs Line  | EOF/GotoLn|{          |  ❚        |Back2Indent|  |  5Char |   EOL     |; z-Cmd·   |\" SetReg·  |
| <TAB>     |  Replace  | Jump Char |JmpNrbyChar|Change     | Misc Cmds |[          |  ❚  PageUp|   word    |  |  Char  |   word    |: z-Cmd·   |' RunMacro |
|           |     Q     |     W     |     F     |     P     |     G     |           |     J     |  ◀▬▬▬ L   |     U     |   Y ▬▬▬▶  |           |           |
+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
 Meta-----> |SelectBlock|           |           |           |           |           |           | PasteAtBOL| PasteBelow| PasteAtEOL|           |           |
 Ctrl-----> |Select All | Redo      | Search    |           |  DelWord  |           |  ❚        |   =<Dn>   |  |  ScrlDn|   =<Tab>  |  JmpOldr  |           |
 Shift----> |Select Line| Insert BOL| Append EOL|           ||D Del->|  ||          |  ❚        |   5Char   |  |  5Char |   5Char   |O OpenUp   || GoCol1   |
 Normal---> |  Select   | Insert    | Append    |Substitute |  Delete>  |\          |  ▼  PgDown|   Char    |  ▼  Char  |   Char    |  OpenDn   |\\: (usr)·  |
 Ltr/Direc->|     A     |  ◀--R     |     S--▶  |     T     |     D     |           |     H     |  ◀--- N   |     E     |   I ---▶  |     O     |           |
            +-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
            |           |           |           |           |           |           |           |           |           |           |
            |           |           |           | Paste-Pop |           |           |           |           |           |           |    · = char arg.
            |   Redo    | Cut To EOL| Copy Line |  <-Paste  | Find File | ? <-Find§ |RpetFndBkwd|  Set Mk·  | < ◀-Dedent| > Indent-▶|    > = move arg.
            |   Undo    |   Cut->   |  Copy >   |  Paste->  |  Buffers  | / Find§-> |Repeat Find|CreateMacro| ,         | .         |
            |     Z     |     X     |     C     |     V     |     B     |           |     K     |     M     |           |           |                        
            +-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

====Commands====

Help:
:hints = :ars = shows/dismisses this prompt (M-x lalopmak-evil-hints)
:key = describes key (C-h k)
:fun = describes function (C-h f)
:variable = describes variable (C-h v)

Shortcuts:
:relative = M-x linum-relative-toggle
:ccmode = M-x centered-cursor-mode
:comment = :c = M-x comment-or-uncomment-region
:git = M-x magit-status
:terminal = M-x sole-terminal-window = opens up terminal window, one buffer
:newterminal = M-x new-terminal-window = opens up new terminal window
:eval = :ev = Evaluates an elisp expression (C-:)
:ielm = M-x ielm-window = opens up lisp evaluation window
")



(require 'lalopmak-buffer)

(defun lalopmak-evil-hints ()
  "Provides hints about this configuration, or closes said hints."
  (interactive)
  (close-visible-buffer-else-call-helper "Colemak-Evil Hints"
                                       with-output-to-temp-buffer 
                                       (princ lalopmak-evil-hintstring)))

(defun lalopmak-evil-scroll-then-center (count motion)
  "Does a motion, then centers"
  (if count
      (funcall motion count) 
    (funcall motion 1))
  (move-to-window-line nil))

;;;;;;;;;;;; Buffer Manipulation macros/functions ;;;;;;;;;;;;;;


(defmacro terminal-command () `(ansi-term (getenv "SHELL")))

(defun new-terminal-window ()
  "Create a terminal buffer.  Can open several."
  (interactive)
  (do-in-new-buffer "*ansi-term*" (terminal-command)))

(defun sole-terminal-window ()
  "Creates or reopens a unique terminal window."
  (interactive)
  (close-visible-window-else-call-helper "Sole Terminal" 
                                       do-in-buffer 
                                       (terminal-command)))

(defun ielm-window ()
  "Open or close a visible ielm buffer."
  (interactive) 
  (close-visible-window-else-call-helper "*ielm*" 
                                       do-func-in-buffer 
                                       'ielm))

;;;Experimental for web server editing
(defmacro minor-mode-running (mode)
  `(and (boundp ',mode) ,mode))

(defun edit-server-edit-mode-running ()
  (minor-mode-running edit-server-edit-mode))



(provide 'lalopmak-evil-libraries)
