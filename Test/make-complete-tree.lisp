(cl:in-package #:clump-test)

(defun make-complete-tree (depth)
  (labels ((aux (depth start)
	     (if (zerop depth)
		 nil
		 (make-instance 'node-with-parent
		   :data (+ start (1- (expt 2 (1- depth))))
		   :left (aux (1- depth) start)
		   :right (aux (1- depth)
			   (+ start (expt 2 (1- depth))))))))
    (aux depth 0)))
