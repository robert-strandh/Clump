(cl:in-package #:clump-2-3-tree)

(defgeneric delete (leaf))

(defgeneric delete-child (parent child))

(defgeneric replace-and-shrink (parent old-child new-child))

(defmethod delete ((leaf leaf))
  (delete-child (parent leaf) leaf))

(defmethod delete-child ((tree tree) child)
  (declare (ignore child))
  (setf (contents tree) nil))

(defmethod delete-child ((node 2-node) child)
  (replace-and-shrink (parent node)
		      node
		      (if (eq child (left node))
			  (right node)
			  (left node))))

(defmethod delete-child ((node 3-node) child)
  (let ((2-node-class (2-node-class (tree node))))
    (if (eq child (left node))
	(replace (parent node)
		 node
		 (make-instance 2-node-class
		   :left (middle node)
		   :right (right node)))
	(if (eq child (middle node))
	    (replace (parent node)
		     node
		     (make-instance 2-node-class
		       :left (left node)
		       :right (right node)))
	    (replace (parent node)
		     node
		     (make-instance 2-node-class
		       :left (left node)
		       :right (middle node)))))))

(defmethod replace-and-shrink ((node 2-node) old-child new-child)
  (let ((2-node-class (2-node-class (tree node)))
	(3-node-class (3-node-class (tree node)))
	(left (left node))
	(right (right node)))
    (if (eq old-child left)
	(if (3-node-p right)
	    (setf (%left node)
		  (make-instance 2-node-class
		    :left new-child
		    :right (left right))
		  (%right node)
		  (make-instance 2-node-class
		    :left (middle right)
		    :right (right right)))
	    (replace-and-shrink (parent node)
				node
				(make-instance 3-node-class
				  :left new-child
				  :middle (left right)
				  :right (right right))))
	(if (3-node-p left)
	    (setf (%right node)
		  (make-instance 2-node-class
		    :left (right left)
		    :right new-child)
		  (%left node)
		  (make-instance 2-node-class
		    :left (left left)
		    :right (middle left)))
	    (replace-and-shrink (parent node)
				node
				(make-instance 3-node-class
				  :left (left left)
				  :middle (right left)
				  :right new-child))))))
