(cl:in-package #:clump-2-3-tree)

;;; This generic function can be used only on an empty tree.
(defgeneric insert (object tree))

(defmethod insert :before (object (tree tree))
  (unless (null (contents tree))
    (error 'tree-for-insertion-must-be-empty
	   :tree tree)))

(defmethod insert (object (tree tree))
  (setf (contents tree)
	(make-instance (leaf-class tree)
	  :contents object
	  :parent tree
	  :tree tree)))

;;; In NODE, split child node OLD-CHILD into two child nodes,
;;; NEW-CHILD-1 and NEW-CHILD-2.
(defgeneric split (node old-child new-child-1 new-child-2))

;; In NODE, replace child OLD-CHILD with the node NEW-CHILD.
(defgeneric replace (node old-child new-child))

(defmethod replace ((node 2-node) old-child new-child)
  (if (eq old-child (left node))
      (setf (%left node) new-child)
      (setf (%right node) new-child)))

(defmethod replace ((node 3-node) old-child new-child)
  (if (eq old-child (left node))
      (setf (%left node) new-child)
      (if (eq old-child (middle node))
	  (setf (%middle node) new-child)
	  (setf (%right node) new-child))))

(defmethod replace ((tree tree) old-child new-child)
  (declare (ignore old-child))
  (setf (contents tree) new-child))

(defmethod split ((node 2-node) old-child new-child-1 new-child-2)
  (let ((parent (parent node))
	(tree (tree node)))
    (replace parent
	     node
	     (if (eq old-child (left node))
		 (make-instance (3-node-class (tree node))
		   :tree tree
		   :parent parent
		   :left new-child-1
		   :middle new-child-2
		   :right (right node))
		 (make-instance (3-node-class (tree node))
		   :tree tree
		   :parent parent
		   :left (left node)
		   :middle new-child-1
		   :right new-child-2)))))

(defmethod split ((node 3-node) old-child new-child-1 new-child-2)
  (let ((parent (parent node))
	(tree (tree node)))
    (cond ((eq old-child (left node))
	   (split (parent node)
		  node
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left new-child-1
		    :right new-child-2)
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left (middle node)
		    :right (right node))))
	  ((eq old-child (middle node))
	   (split (parent node)
		  node
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left (left node)
		    :right new-child-1)
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left new-child-2
		    :right (right node))))
	  (t
	   (split (parent node)
		  node
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left (left node)
		    :right (middle node))
		  (make-instance (2-node-class (tree node))
		    :tree tree
		    :parent parent
		    :left new-child-1
		    :right new-child-2))))))

(defmethod split ((tree tree) old-child new-child-1 new-child-2)
  (setf (contents tree)
	(make-instance (2-node-class tree)
	  :tree tree
	  :parent tree
	  :left new-child-1
	  :right new-child-2)))

(defgeneric insert-before (object leaf))

(defmethod insert-before (object (leaf leaf))
  (let ((tree (tree leaf))
	(parent (parent leaf)))
    (split (parent leaf)
	   leaf
	   (make-instance (leaf-class tree)
	     :parent parent
	     :tree tree
	     :contents object)
	   leaf)))

(defgeneric insert-after (object leaf))

(defmethod insert-after (object (leaf leaf))
  (let ((tree (tree leaf))
	(parent (parent leaf)))
    (split (parent leaf)
	   leaf
	   leaf
	   (make-instance (leaf-class tree)
	     :parent parent
	     :tree tree
	     :contents object))))
