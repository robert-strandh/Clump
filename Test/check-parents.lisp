(cl:in-package #:clump-test)

(defun check-parents (tree)
  (unless (null tree)
    (let ((left (clump-binary-tree:left tree))
	  (right (clump-binary-tree:right tree)))
      (unless (null left)
	(assert (eq (clump-binary-tree:parent left) tree))
	(assert (eq (clump-binary-tree:parent right) tree))))))
