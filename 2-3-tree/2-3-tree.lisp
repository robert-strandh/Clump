(cl:in-package #:clump-2-3-tree)

(defclass tree ()
  ((%contents :initform nil :accessor contents)))

(defclass node ()
  ((%parent :initarg :parent :accessor parent)))

(defclass leaf (node)
  ((%contents :initarg :contents :accessor contents)))

(defclass 2-node (node)
  ((%left :initarg :left :accessor left)
   (%right :initarg :right :accessor right)))

