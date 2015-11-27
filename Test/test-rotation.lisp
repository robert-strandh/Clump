(cl:in-package #:clump-test)

(defun test-rotation-with-node (tree node)
  (let ((traversal (in-order-traversal tree))
	(root-p (eq tree node)))
    (cond ((and (null (clump-binary-tree:left node))
		(null (clump-binary-tree:right node)))
	   nil)
	  ((null (clump-binary-tree:left node))
	   (setf node (clump-binary-tree:rotate-left node)))
	  ((null (clump-binary-tree:right node))
	   (setf node (clump-binary-tree:rotate-right node)))
	  ((< (random 1.0) 0.5)
	   (setf node (clump-binary-tree:rotate-left node)))
	  (t
	   (setf node (clump-binary-tree:rotate-right node))))
    (when root-p
      (setf tree node))
    (check-parents tree)
    (assert (equal traversal (in-order-traversal tree)))))

(defun test-rotation-of-tree (tree)
  (test-rotation-with-node tree (select-random-node tree)))

(defun test-rotation ()
  (loop repeat 100000
	for tree = (random-tree 'node-with-parent)
	do (fixup-parents tree)
	   (test-rotation-of-tree tree)))
