;;; systemrdl-mode.el --- major mode for editing systemrdl build files
;;
;; Simple mode for Systemrdl files
;;
;; Version 0.1
;;
;; =================================================================================================
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses


;; INSTALLING THE MODE
;; ===================
;;
;; Just add this to your .emacs file:
;; (require 'systemrdl-mode)


;; =================================================================================================
;;; Code:

(defvar systemrdl-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; Populate the syntax TABLE (copied from verilog mode)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?+ "." table)
    (modify-syntax-entry ?- "." table)
    (modify-syntax-entry ?= "." table)
    (modify-syntax-entry ?% "." table)
    (modify-syntax-entry ?< "." table)
    (modify-syntax-entry ?> "." table)
    (modify-syntax-entry ?& "." table)
    (modify-syntax-entry ?| "." table)
    (modify-syntax-entry ?` "w" table)  ; ` is part of definition symbols in Verilog
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?\' "." table)

    (modify-syntax-entry ?/  ". 124b" table)
    (modify-syntax-entry ?*  ". 23"   table)
    (modify-syntax-entry ?\n "> b"    table)
    table))

(defconst systemrdl-font-lock-keywords
  (list
   '("//.*"
     . font-lock-comment-face)
   '("`\\w+"
     .  font-lock-preprocessor-face)
   '("\\<\\(`.*\\)\\>"
     . font-lock-keyword-face) ; instructions
   '("\\<\\(sw\\|hw\\|desc\\|name\\|reset\\|next\\regwidth\\|accesswidth\\|errextbus\\|intr\\|halt\\|shared\\||resetsignal\\|rclr\\|rset\\|onread\\|woset\\|woclr\\|onwrite\\|swwe\\|swwel\\|swmod\\|swacc\\|singlepulse\\|we\\|we1\\|anded\\|ored\\|xored\\|fieldwidth\\|hwclr\\|hwst\\|hwenable\\|hwmask\\|intr\\|constraint\\)\\>"
     . font-lock-type-face) ; registers
   '("\\<\\W*\\w+:"
     . font-lock-function-name-face)
   '("\\<\\(reg\\|regfile\\|addrmap\\|field\\|default\\|alignment\\|mementries\\|memwidth\\|sharedextbus\\|errextbus\\|bigendian\\|littleendian\\|addressing\\|rsvdset\\|rsvdsetX\\|msb0\\|lsb0\\|hdl_path\\|hdl_path_slice\\|hdl_path_gate\\|hdl_path_gate_slice\\)\\>"
     . font-lock-variable-name-face) ;; numbers: dec and hex
   )
  "Default highlighting expressions for SystemRDL mode.")


;;;
(define-derived-mode systemrdl-mode sh-mode "SystemRDL"
  "systemrdl major mode."
  (set (make-local-variable 'comment-start) "// ")
  (set (make-local-variable 'comment-end) "/*")
  (set (make-local-variable 'comment-start-skip) "*/")
  (set (make-local-variable 'font-lock-defaults)
       '(systemrdl-font-lock-keywords))
  (set (make-local-variable 'tab-width) 4)
  (set (make-local-variable 'sh-indentation) 4)
  )

;; a .rdl file will automatically load this mode
(add-to-list 'auto-mode-alist '("\\.rdl\\'" . systemrdl-mode))

(provide 'systemrdl-mode)

;;; systemrdl-mode ends here

(defconst my-systemrdl-style
  '((sh-indentation . 4)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-systemrdl-style t)))
