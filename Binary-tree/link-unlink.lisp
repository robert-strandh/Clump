(cl:in-package #:clump-binary-tree)

;;; Make CHILD the left child of NODE.
(defgeneric link-left (parent child))

;;; Make CHILD the right child of PARENT.
(defgeneric link-right (parent child))

;;; Remove CHILD as the left child of PARENT.
(defgeneric unlink-left (parent child))

;;; Remove CHILD as the right child of PARENT.
(defgeneric unlink-right (parent child))

