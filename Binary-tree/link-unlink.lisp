(cl:in-package #:clump-binary-tree)

;;; Make CHILD the left child of NODE.
(defgeneric link-left (parent child))

(defmethod link-left ((parent node) child)
  (setf (left parent) child))

(defmethod link-left ((parent node-with-parent) (child node-with-parent))
  (call-next-method)
  (setf (parent child) parent))

;;; Make CHILD the right child of PARENT.
(defgeneric link-right (parent child))

(defmethod link-right ((parent node) child)
  (setf (right parent) child))

(defmethod link-right ((parent node-with-parent) (child node-with-parent))
  (call-next-method)
  (setf (parent child) parent))

;;; Remove CHILD as the left child of PARENT.
(defgeneric unlink-left (parent child))

(defmethod unlink-left ((parent node) child)
  (setf (left parent) nil))

(defmethod unlink-left ((parent node-with-parent) (child node-with-parent))
  (call-next-method)
  (setf (parent child) nil))

;;; Remove CHILD as the right child of PARENT.
(defgeneric unlink-right (parent child))

(defmethod unlink-right ((parent node) child)
  (setf (right parent) nil))

(defmethod unlink-right ((parent node-with-parent) (child node-with-parent))
  (call-next-method)
  (setf (parent child) nil))

