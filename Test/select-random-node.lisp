(cl:in-package #:clump-test)

;;; TREE is a non-empty tree.  We select a random node from the tree. 
(defun select-random-node (tree)
  (cond (;; If the node has no children, we return it.  If it has at
	 ;; least one child we return it with probability of 0.2. 
	 (or (and (null (clump-binary-tree:left tree))
		  (null (clump-binary-tree:right tree)))
	     (< (random 1.0) 0.2))
	 tree)
	;; If the node TREE was not returned, it means that it has at
	;; least one child, and it was not returned because of the
	;; probability test.  We then recursively select a node from
	;; either the left or the right sub-tree as appropriate.
	((null (clump-binary-tree:left tree))
	 ;; If the left child is NIL, we have no choice but to select
	 ;; a random node from the right sub-tree.
	 (select-random-node (clump-binary-tree:right tree)))
	((null (clump-binary-tree:right tree))
	 ;; If the right child is NIL, we have no choice but to select
	 ;; a random node from the left sub-tree.
	 (select-random-node (clump-binary-tree:left tree)))
	;; We come here if none of the children is NIL.  We select a
	;; node from the left or the right sub-tree with probability
	;; 0.5.
	((< (random 1.0) 0.5)
	 (select-random-node (clump-binary-tree:left tree)))
	(t
	 (select-random-node (clump-binary-tree:right tree)))))
