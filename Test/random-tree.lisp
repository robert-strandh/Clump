(cl:in-package #:clump-test)

(defun random-tree (node-class &optional (node-probability 1.0))
  (if (< (random 1.0) node-probability)
      (make-instance node-class
	:data (random 20)
	:left (random-tree node-class (* 0.9 node-probability))
	:right (random-tree node-class (* 0.9 node-probability)))
      nil))
