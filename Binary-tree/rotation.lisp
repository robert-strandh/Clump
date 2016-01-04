(cl:in-package #:clump-binary-tree)

(defgeneric rotate-left (tree))

(defgeneric rotate-right (tree))

(defmethod rotate-left (tree)
  (error 'invalid-binary-tree :tree tree))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function ROTATE-LEFT-WITH-CHILD.
;;;
;;; Given a NODE and the right CHILD of that node, rotate left so that
;;; CHILD becomes the root and NODE becomes the left child of CHILD.
;;;
;;; This function should not be called directly by client code.  It is
;;; called by the function ROTATE-LEFT when that function is called
;;; with an instance of (a subclass of) NODE, passing NODE and its
;;; right child.
;;;
;;; Client code can define methods on this generic function.  Such
;;; methods may be specialized to strict subclasses of either
;;; SIMPLE-NODE or NODE-WITH-PARENT.
;;;
;;; When ROTATE-LEFT-WITH-CHILD is called from ROTATE-LEFT, we know
;;; that NODE is and instance of (a subclass of) NODE, and we know
;;; that CHILD is either the empty tree (i.e., NIL) or an instance of
;;; (a subclass of) NODE, so we do not have to take into account other
;;; possibilities for CHILD.

(defgeneric rotate-left-with-child (node child))

(defmethod rotate-left-with-child ((node node) (child null))
  (error 'right-subtree-must-be-non-nil :tree node))

;;; Given a tree with the following shape:
;;;
;;;         node
;;;         /  \
;;;        /    \
;;;       l    child
;;;            /    \
;;;           /      \
;;;     grand-child  rr
;;;
;;; we turn it into a tree with this shape:
;;;
;;;           child
;;;          / \
;;;         /   \
;;;       node  rr
;;;       /  \
;;;      /    \
;;;     l   grand-child
;;;
;;; The node CHILD is returned.
(defmethod rotate-left-with-child ((node node) (child node))
  (let ((grand-child (left child)))
    (unlink-right node child)
    (unlink-left child grand-child)
    (link-right node grand-child)
    (link-left child node)
    child))

(defmethod rotate-left-with-child :around
    ((node node-with-parent) (child node-with-parent))
  (let ((sub-tree-parent (parent node)))
    (cond ((null sub-tree-parent)
	   (call-next-method)
	   (setf (parent child) nil))
	  ((eq node (left sub-tree-parent))
	   (unlink-left sub-tree-parent node)
	   (call-next-method)
	   (link-left sub-tree-parent child))
	  (t
	   (unlink-right sub-tree-parent node)
	   (call-next-method)
	   (link-right sub-tree-parent child))))
  child)

(defmethod rotate-left ((tree node))
  (rotate-left-with-child tree (right tree)))

(defmethod rotate-right (tree)
  (error 'invalid-binary-tree :tree tree))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function ROTATE-RIGHT-WITH-CHILD.
;;;
;;; Given a NODE and the left CHILD of that node, rotate right so that
;;; CHILD becomes the root and NODE becomes the right child of CHILD.
;;;
;;; This function should not be called directly by client code.  It is
;;; called by the function ROTATE-RIGHT when that function is called
;;; with an instance of (a subclass of) NODE, passing NODE and its
;;; left child.
;;;
;;; Client code can define methods on this generic function.  Such
;;; methods may be specialized to strict subclasses of either
;;; SIMPLE-NODE or NODE-WITH-PARENT.
;;;
;;; When ROTATE-RIGHT-WITH-CHILD is called from ROTATE-RIGHT, we know
;;; that NODE is and instance of (a subclass of) NODE, and we know
;;; that CHILD is either the empty tree (i.e., NIL) or an instance of
;;; (a subclass of) NODE, so we do not have to take into account other
;;; possibilities for CHILD.

(defgeneric rotate-right-with-child (node child))

(defmethod rotate-right-with-child ((node node) (child null))
  (error 'left-subtree-must-be-non-nil :tree node))

;;; Given a tree with the following shape:
;;;
;;;          node
;;;          /  \
;;;         /    \
;;;      child    r
;;;      /   \
;;;     /     \
;;;    ll  grand-child
;;;
;;; we turn it into a tree with this shape:
;;;
;;;        child
;;;        /   \
;;;       /     \
;;;      ll    node
;;;            /  \
;;;           /    \
;;;   grand-child   r
;;;
;;; The node L is returned
(defmethod rotate-right-with-child ((node node) (child node))
  (let ((grand-child (right child)))
    (unlink-left node child)
    (unlink-right child grand-child)
    (link-left node grand-child)
    (link-right child node)
    child))

(defmethod rotate-right-with-child :around
    ((node node-with-parent) (child node-with-parent))
  (let ((sub-tree-parent (parent node)))
    (cond ((null sub-tree-parent)
	   (call-next-method)
	   (setf (parent child) nil))
	  ((eq node (left sub-tree-parent))
	   (unlink-left sub-tree-parent node)
	   (call-next-method)
	   (link-left sub-tree-parent child))
	  (t
	   (unlink-right sub-tree-parent node)
	   (call-next-method)
	   (link-right sub-tree-parent child))))
  child)

(defmethod rotate-right ((tree node))
  (rotate-right-with-child tree (left tree)))
