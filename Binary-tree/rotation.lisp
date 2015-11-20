(cl:in-package #:clump-binary-tree)

(defgeneric rotate-left (tree))

(defgeneric rotate-right (tree))

(defmethod rotate-left (tree)
  (error 'invalid-binary-tree :tree tree))

(defgeneric rotate-left-with-child (node child))

;;; Given a tree with the following shape:
;;;
;;;         tree
;;;         /  \
;;;        /    \
;;;       l     r
;;;            / \
;;;           /   \
;;;          rl   rr
;;;
;;; we turn it into a tree with this shape:
;;;
;;;           r
;;;          / \
;;;         /   \
;;;       tree  rr
;;;       /  \
;;;      /    \
;;;     l     rl
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

(defmethod rotate-right (tree)
  (error 'invalid-binary-tree :tree tree))

;;; Given a tree with the following shape:
;;;
;;;          tree
;;;          /  \
;;;         /    \
;;;        l      r
;;;       / \
;;;      /   \
;;;     ll   lr
;;;
;;; we turn it into a tree with this shape:
;;;
;;;         l
;;;        / \
;;;       /   \
;;;      ll   tree
;;;           /  \
;;;          /    \
;;;         lr     r
;;;
;;; The node L is returned
(defmethod rotate-right ((tree node))
  (when (null (left tree))
    (error 'left-subtree-must-be-non-nil :tree tree))
  (let* ((l (left tree))
	 (lr (right l)))
    (setf (left tree) lr
	  (right l) tree)
    l))
