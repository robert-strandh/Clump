(cl:in-package #:clump-test)

(defclass simple-node (clump-binary-tree:simple-node)
  ((%data :initarg :data :reader data)))

(defclass node-with-parent (clump-binary-tree:node-with-parent)
  ((%data :initarg :data :reader data)))

(defun msn (data left right)
  (make-instance 'simple-node :data data :left left :right right))
