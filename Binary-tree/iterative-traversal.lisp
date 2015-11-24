(cl:in-package #:clump-binary-tree)

(defgeneric iterative-traversal (tree pre in post))

(defmethod iterative-traversal ((tree node-with-parent) pre in post)
  (let ((current-node tree))
    (tagbody
     pre
       (if (funcall pre current-node)
	   (let ((left (left current-node)))
	     (if (null left)
		 (go in)
		 (progn (setf current-node left)
			(go pre))))
	   (go in))
     in
       (if (funcall in current-node)
	   (let ((right (right current-node)))
	     (if (null right)
		 (go post)
		 (progn (setf current-node right)
			(go pre))))
	   (go post))
     post
       (funcall post current-node)
       (let ((parent (parent current-node)))
	 (if (null parent)
	     (return-from iterative-traversal)
	     (if (eq current-node (left parent))
		 (progn (setf current-node parent)
			(go in))
		 (progn (setf current-node parent)
			(go post))))))))

