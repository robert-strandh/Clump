(cl:in-package #:clump-binary-tree)

(defgeneric replace-child (node old-child new-child))

(defmethod replace-child ((node null) (old-child node) new-child)
  new-child)
