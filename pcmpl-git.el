;;; pcmpl-git.el --- functions for dealing with git completions

;; Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004,
;;   2005, 2006, 2007, 2008, 2009 Free Software Foundation, Inc.

;; Author: Kensuke Kaneko <kyanny@gmail.com>

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; These functions provide completion rules for the `git' tool.

;;; Code:

(provide 'pcmpl-git)

(require 'pcomplete)
(require 'executable)

(defgroup pcmpl-git nil
  "Functions for dealing with Git completions."
  :group 'pcomplete)

;; User Variables:

(defcustom pcmpl-git-binary (or (executable-find "git") "git")
  "The full path of the 'git' binary."
  :type 'file
  :group 'pcmpl-git)

;; Functions:

;;;###autoload
(defun pcomplete/git ()
  "Completion rules for the `git' command."
  (let ((pcomplete-help "(git)Invoking Git"))
    (pcomplete-here (pcmpl-git-commands))
    (cond (t
           (while (pcomplete-here (pcmpl-git-commands)))))))

(defun pcmpl-git-commands ()
  "Return a list of available Git commands."
  (with-temp-buffer
    (call-process pcmpl-git-binary nil t nil "help")
    (goto-char (point-min))
    (let (cmds)
      (while (re-search-forward "^\s+\\([a-z]+\\)" nil t)
        (setq cmds (cons (match-string 1) cmds)))
      (pcomplete-uniqify-list cmds))))

;; arch-tag: 
;;; pcmpl-git.el ends here
