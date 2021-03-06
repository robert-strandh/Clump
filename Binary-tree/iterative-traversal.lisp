(cl:in-package #:clump-binary-tree)

;;;; Depth-first iterative traversal.
;;;;
;;;; PRE, IN, and POST are functions of a single variable.  Each of
;;;; these functions is called with a NODE as its argument.
;;;;
;;;; Before a node is visited, PRE is called with that node as an
;;;; argument.  If PRE returns true, this is an indication that the
;;;; left sub-tree of that node should be visited.  Otherwise, the
;;;; current node is treated as if its left sub-tree were NIL.
;;;;
;;;; After the left sub-tree of some node has been visited, IN is
;;;; called with that node as an argument.  If IN returns true, this
;;;; is an indication that the right sub-tree of that node should be
;;;; visited.  Otherwise, the current node is treated as if its right
;;;; sub-tree were NIL.
;;;;
;;;; After the right sub-tree of some node has been visited, POST is
;;;; called with that node as an argument.  The return value of POST
;;;; is ignored.

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

(defmethod iterative-traversal ((tree simple-node) pre in post)
  (let ((current-node tree)
	(parents '())
	(children '()))
    (flet ((go-up ()
	     (let ((temp parents))
	       (setf current-node (pop parents))
	       (setf (cdr temp) children)
	       (setf children temp)))
	   (go-down (node)
	     (if (null children)
		 (push current-node parents)
		 (let ((temp children))
		   (setf children (cdr temp))
		   (setf (car temp) current-node)
		   (setf (cdr temp) parents)
		   (setf parents temp)))
	     (setf current-node node)))
      (tagbody
       pre
	 (if (funcall pre current-node)
	     (let ((left (left current-node)))
	       (if (null left)
		   (go in)
		   (progn (go-down left)
			  (go pre))))
	     (go in))
       in
	 (if (funcall in current-node)
	     (let ((right (right current-node)))
	       (if (null right)
		   (go post)
		   (progn (go-down right)
			  (go pre))))
	     (go post))
       post
	 (funcall post current-node)
	 (if (null parents)
	     (return-from iterative-traversal)
	     (let ((parent (car parents)))
	       (if (eq current-node (left parent))
		   (progn (go-up)
			  (go in))
		   (progn (go-up)
			  (go post)))))))))
