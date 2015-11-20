(cl:in-package #:clump-binary-tree)

(defgeneric left (node))
(defgeneric right (node))
(defgeneric (setf left) (new-left node))
(defgeneric (setf right) (new-right node))

(defclass node ()
  ((%left :initarg :left :initform nil :accessor left)
   (%right :initarg :right :initform nil :accessor right)))

(defgeneric node-p (tree)
  (:method (tree) nil)
  (:method ((tree node)) t))

(defmethod initialize-instance :before ((object node) &key left right)
  (unless (or (null left) (node-p left))
    (error 'invalid-binary-tree :tree left))
  (unless (or (null right) (node-p right))
    (error 'invalid-binary-tree :tree right)))

(defclass simple-node (node)
  ())

(defclass node-with-parent (node)
  ((%parent :initarg :parent :initform nil :accessor parent)))
