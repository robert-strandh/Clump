(cl:in-package #:clump-test)

(defun indent (n)
  (loop repeat n
	do (format t " ")))

(defun print-tree (tree indentation)
  (unless (null tree)
    (indent indentation)
    (format t "~a~%" (data tree))
    (print-tree (clump-binary-tree:left tree) (+ indentation 2))
    (print-tree (clump-binary-tree:right tree) (+ indentation 2))))
