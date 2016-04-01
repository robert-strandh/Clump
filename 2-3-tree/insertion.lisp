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

;;; In NODE, split OLD-CHILD into two children, NEW-CHILD-1 and
;;; NEW-CHILD-2.
(defgeneric split (node old-child new-child-1 new-child-2))
