(cl:in-package #:clump-test)

(defun random-tree (&optional (node-probability 1.0))
  (if (< (random 1.0) node-probability)
      (make-instance 'node
	:data (random 20)
	:left (random-tree (* 0.9 node-probability))
	:right (random-tree (* 0.9 node-probability)))
      nil))
