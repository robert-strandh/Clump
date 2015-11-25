(cl:in-package #:clump-test)

(defclass node (clump-binary-tree:node-with-parent)
  ((%data :initarg :data :reader data)))
