(cl:in-package #:clump-2-3-tree)

;;; This generic function can be used only on an empty tree.
(defgeneric insert (object tree))

(defmethod insert :before (object (tree tree))
  (unless (null (contents tree))
    (error "Do this error message better.")))

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
      (setf (left node) new-child)
      (setf (right node) new-child)))

(defmethod replace ((node 3-node) old-child new-child)
  (if (eq old-child (left node))
      (setf (left node) new-child)
      (if (eq old-child (middle node))
	  (setf (middle node) new-child)
	  (setf (right node) new-child))))
