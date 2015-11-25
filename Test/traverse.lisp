(cl:in-package #:clump-test)

(defun traverse (tree traversal-function)
  (let ((result '()))
    (flet ((pre (node)
	     (push `(pre ,(data node)) result))
	   (in (node)
	     (push `(in ,(data node)) result))
	   (post (node)
	     (push `(post ,(data node)) result)))
      (funcall traversal-function tree #'pre #'in #'post))
    result))

	   
