(cl:in-package #:clump-2-3-tree)

;;; This generic function can be used only on an empty tree.
(defgeneric insert (object tree))

(defmethod insert :before (object (tree tree))
  (unless (null (contents tree))
    (error "Do this error message better.")))
