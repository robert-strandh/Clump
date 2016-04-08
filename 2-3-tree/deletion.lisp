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
  (let ((2-node-class (2-node-class (tree node)))
	(tree (tree node))
	(parent (parent node)))
    (if (eq child (left node))
	(replace (parent node)
		 node
		 (make-instance 2-node-class
		   :tree tree
		   :parent parent
		   :left (middle node)
		   :right (right node)))
	(if (eq child (middle node))
	    (replace (parent node)
		     node
		     (make-instance 2-node-class
		       :tree tree
		       :parent parent
		       :left (left node)
		       :right (right node)))
	    (replace (parent node)
		     node
		     (make-instance 2-node-class
		       :tree tree
		       :parent parent
		       :left (left node)
		       :right (middle node)))))))

(defmethod replace-and-shrink ((tree tree) old-child new-child)
  (declare (ignore old-child))
  (setf (contents tree) new-child))

(defmethod replace-and-shrink ((node 2-node) old-child new-child)
  (let ((2-node-class (2-node-class (tree node)))
	(3-node-class (3-node-class (tree node)))
	(left (left node))
	(right (right node))
	(tree (tree node))
	(parent (parent node)))
    (if (eq old-child left)
	(if (3-node-p right)
	    (setf (%left node)
		  (make-instance 2-node-class
		    :tree tree
		    :parent node
		    :left new-child
		    :right (left right))
		  (%right node)
		  (make-instance 2-node-class
		    :tree tree
		    :parent node
		    :left (middle right)
		    :right (right right)))
	    (replace-and-shrink (parent node)
				node
				(make-instance 3-node-class
				  :tree tree
				  :parent parent
				  :left new-child
				  :middle (left right)
				  :right (right right))))
	(if (3-node-p left)
	    (setf (%right node)
		  (make-instance 2-node-class
		    :tree tree
		    :parent node
		    :left (right left)
		    :right new-child)
		  (%left node)
		  (make-instance 2-node-class
		    :tree tree
		    :parent node
		    :left (left left)
		    :right (middle left)))
	    (replace-and-shrink (parent node)
				node
				(make-instance 3-node-class
				  :tree tree
				  :parent parent
				  :left (left left)
				  :middle (right left)
				  :right new-child))))))

(defmethod replace-and-shrink ((node 3-node) old-child new-child)
  (let ((2-node-class (2-node-class (tree node)))
	(3-node-class (3-node-class (tree node)))
	(parent (parent node))
	(tree (tree node))
	(left (left node))
	(middle (middle node))
	(right (right node)))
    (cond ((eq old-child left)
	   (if (3-node-p middle)
	       (setf (%left node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left new-child
		       :right (left middle))
		     (%middle node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left (middle middle)
		       :right (right middle)))
	       ;; MIDDLE is a 2-node.  Turn NEW-CHILD and the two
	       ;; children of MIDDLE into a 3-node.  Replace NODE
	       ;; (which is a 3-node) with a 2-node.
	       (replace (parent node)
			node
			(make-instance 2-node-class
			  :tree tree
			  :parent parent
			  :left (make-instance 3-node-class
				  :tree tree
				  :left new-child
				  :middle (left middle)
				  :right (right middle))
			  :right right))))
	  ((eq old-child middle)
	   (if (3-node-p left)
	       (setf (%middle node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left (right left)
		       :right new-child)
		     (%left node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left (left left)
		       :right (middle left)))
	       ;; LEFT is a 2-node.  Turn the two children of LEFT and
	       ;; NEW-CHILD into a 3-node.  Replace NODE (which is a
	       ;; 3-node) with a 2-node.
	       (replace (parent node)
			node
			(make-instance 2-node-class
			  :tree tree
			  :parent parent
			  :left (make-instance 3-node-class
				  :tree tree
				  :left (left left)
				  :middle (right left)
				  :right new-child)
			  :right right))))
	  (t
	   ;; OLD-CHILD is identical to RIGHT.
	   (if (3-node-p middle)
	       (setf (%right node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left (right middle)
		       :right new-child)
		     (%middle node)
		     (make-instance 2-node-class
		       :tree tree
		       :parent node
		       :left (left middle)
		       :right (middle middle)))
	       ;; MIDDLE is a 2-node.  Turn the two children of MIDDLE
	       ;; and NEW-CHILD into a 3-node.  Replace NODE (which is
	       ;; a 3-node) with a 2-node.
	       (replace (parent node)
			node
			(make-instance 2-node-class
			  :tree tree
			  :parent parent
			  :left (left node)
			  :right (make-instance 3-node-class
				   :tree tree
				   :left (left middle)
				   :middle (right middle)
				   :right new-child))))))))
