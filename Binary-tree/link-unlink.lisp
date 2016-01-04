(cl:in-package #:clump-binary-tree)

;;; Make CHILD the left child of NODE.
(defgeneric link-left (parent child))

(defmethod link-left ((parent node) (child node))
  (setf (left parent) child))

(defmethod link-left ((parent node-with-parent) (child node-with-parent))
  (call-next-method)
  (setf (parent child) parent))

;;; Make CHILD the right child of PARENT.
(defgeneric link-right (parent child))

;;; Remove CHILD as the left child of PARENT.
(defgeneric unlink-left (parent child))

;;; Remove CHILD as the right child of PARENT.
(defgeneric unlink-right (parent child))

