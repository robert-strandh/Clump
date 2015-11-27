(cl:in-package #:clump-test)

(defun in-order-traversal (tree)
  (let ((result '()))
    (clump-binary-tree:recursive-traversal
     tree
     ;; Function PRE.  Do nothing.
     (constantly t)
     ;; Function IN.
     (lambda (node)
       (push (data node) result)
       t)
     ;; Function POST.  Do nothing.
     #'identity)
    result))
