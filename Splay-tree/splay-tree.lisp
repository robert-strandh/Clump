(cl:in-package #:clump-splay-tree)

(defclass node (clump-binary-tree:node)
  ((%parent :initarg :parent :initform nil :accessor parent)))

(defgeneric splay-step (node))

(defgeneric splay (node))
