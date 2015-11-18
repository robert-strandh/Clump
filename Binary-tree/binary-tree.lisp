(cl:in-package #:clump-binary-tree)

(defgeneric left (node))
(defgeneric right (node))
(defgeneric (setf left) (new-left node))
(defgeneric (setf right) (new-right node))

(defclass node ()
  ((%left :initarg :left :initform nil :accessor left)
   (%right :initarg :right :initform nil :accessor right)))
