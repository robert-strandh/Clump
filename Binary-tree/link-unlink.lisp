(cl:in-package #:clump-binary-tree)

;;; Make CHILD the left child of NODE.
(defgeneric link-left (node child))

;;; Make CHILD the right child of NODE.
(defgeneric link-right (node child))

;;; Remove CHILD as the left child of NODE.
(defgeneric unlink-left (node child))

;;; Remove CHILD as the right child of NODE.
(defgeneric unlink-right (node child))
