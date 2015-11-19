(cl:in-package #:clump-binary-tree)

(defgeneric rotate-left (tree))

(defgeneric rotate-right (tree))

(defmethod rotate-left (tree)
  (error 'invalid-binary-tree :tree tree))

;;; Given a tree with the following shape:
;;;
;;;         tree
;;;        /    \
;;;       /      \
;;;      l       r
;;;             / \
;;;            /   \
;;;           rl   rr
;;;
;;; we turn it into a tree with this shape:
;;;
;;;           r
;;;          / \
;;;         /   \
;;;       tree  rr
;;;       /   \
;;;      /     \
;;;     l      rl
;;;
;;; The node R is returned
(defmethod rotate-left ((tree node))
  (when (null (right tree))
    (error 'right-subtree-must-be-non-nil :tree tree))
  (let* ((r (right tree))
	 (rl (left r)))
    (setf (right tree) rl
	  (left r) tree)
    r))
