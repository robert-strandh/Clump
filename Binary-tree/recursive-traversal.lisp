(cl:in-package #:clump-binary-tree)

(defgeneric recursive-traversal (tree pre in post))

(defmethod recursive-traversal ((tree node) pre in post)
  (labels ((traverse (node)
	     (if (null node)
		 nil
		 (progn (when (funcall pre node)
			  (traverse (left node)))
			(when (funcall in node)
			  (traverse (right node)))
			(funcall post node)))))
    (traverse tree)))
