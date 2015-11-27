(cl:in-package #:clump-test)

(defun indent (n)
  (loop repeat n
	do (format t " ")))

(defun print-tree (tree indentation)
  (indent indentation)
  (if (null tree)
      (format t "-~%")
      (progn (format t "~a~%" (data tree))
	     (print-tree (clump-binary-tree:left tree) (+ indentation 2))
	     (print-tree (clump-binary-tree:right tree) (+ indentation 2)))))
