(cl:in-package #:clump-binary-tree)

(defgeneric iterative-traversal (tree enter leave))

(defmethod iterative-traversal ((tree node-with-parent) enter leave)
  (let ((current-node tree))
    (loop do (if (or (not (funcall enter current-node))
		     (and (null (left current-node))
			  (null (right current-node))))
		 (loop for parent = (parent current-node)
		       until (or (null parent)
				 (and (eq current-node (left parent))
				      (not (null (right parent)))))
		       do (funcall leave current-node)
			  (setf current-node parent)
		       finally (if (null parent)
				   (return-from iterative-traversal)
				   (setf current-node (right parent))))
		 (setf current-node
		       (or (left current-node)
			   (right current-node)))))))
		 
		 
    
