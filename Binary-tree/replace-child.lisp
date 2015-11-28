(cl:in-package #:clump-binary-tree)

(defgeneric replace-child (node old-child new-child))

(defmethod replace-child ((node null) (old-child node) new-child)
  new-child)

(defmethod replace-child ((node node) (old-child node) new-child)
  (cond ((eq old-child (left node))
	 (setf (left node) new-child))
	((eq old-child (right node))
	 (setf (right node) new-child))
	(t
	 (error 'must-be-child
		:tree node
		:child old-child))))
