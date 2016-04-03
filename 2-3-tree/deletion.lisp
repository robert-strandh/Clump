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

(defmethod delete-child ((node 3-node) child)
  (let ((2-node-class (2-node-class (tree node))))
    (if (eq child (left node))
	(replace-and-shrink (parent node)
			    (make-instance 2-node-class
			      :left (middle node)
			      :right (right node)))
	(if (eq child (middle node))
	    (replace-and-shrink (parent node)
				(make-instance 2-node-class
				  :left (left node)
				  :right (right node)))
	    (replace-and-shrink (parent node)
				(make-instance 2-node-class
				  :left (left node)
				  :right (middle node)))))))
