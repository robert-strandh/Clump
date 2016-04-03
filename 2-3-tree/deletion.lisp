(cl:in-package #:clump-2-3-tree)

(defgeneric delete (leaf))

(defgeneric delete-child (parent child))

(defgeneric replace-and-shrink (parent child))

(defmethod delete ((leaf leaf))
  (delete-child (parent leaf) leaf))

(defmethod delete-child ((tree tree) child)
  (declare (ignore child))
  (setf (contents tree) nil))

(defmethod delete-child ((node 2-node) child)
  (replace-and-shrink (parent node)
		      (if (eq child (left node))
			  (right node)
			  (left node))))
