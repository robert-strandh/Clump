(cl:in-package #:clump-test)

;;; We know that the SPLAY operation preserves an in-order traversal
;;; of the tree.  Therefore, we test the SPLAY operation by the
;;; following steps:
;;;
;;;  1. Generate a random tree
;;;  2. Make an in-order traversal of that tree, saving the result
;;;  3. Select a random node of the random tree.
;;;  4. Splay the selected node.
;;;  5. Make an in-order traversal of the splayed node, saving the result.
;;;  6. Compare the two in-order traversals.

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

(defun test-one-splay-with-node (tree node)
  (let* ((traversal1 (in-order-traversal tree))
	 (ignore (clump-binary-tree:splay node))
	 (traversal2 (in-order-traversal node)))
    (declare (ignore ignore))
    (assert (equal traversal1 traversal2))))

(defun test-one-splay (tree)
  (test-one-splay-with-node tree (select-random-node tree)))
