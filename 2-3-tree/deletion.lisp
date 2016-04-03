(cl:in-package #:clump-2-3-tree)

(defgeneric delete (leaf))

(defgeneric delete-child (parent child))

(defmethod delete ((leaf leaf))
  (delete-child (parent leaf) leaf))
