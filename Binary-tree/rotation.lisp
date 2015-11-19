(cl:in-package #:clump-binary-tree)

(defgeneric rotate-left (tree))

(defgeneric rotate-right (tree))

(defmethod rotate-left (tree)
  (error 'invalid-binary-tree :tree tree))

(defmethod rotate-left ((tree node))
  (when (null (right tree))
    (error 'right-subtree-must-be-non-nil :tree tree))
