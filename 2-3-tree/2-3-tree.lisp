(cl:in-package #:clump-2-3-tree)

(defclass tree ()
  ((%contents :initform nil :accessor contents)
   (%leaf-class :initarg :leaf-class :reader leaf-class)
   (%2-node-class :initarg :2-node-class :reader 2-node-class)
   (%3-node-class :initarg :3-node-class :reader 3-node-class)))

(defclass node ()
  ((%parent :initarg :parent :accessor parent)
   (%tree :initarg :tree :reader tree)))

(defclass leaf (node)
  ((%contents :initarg :contents :accessor contents)))

(defclass 2-node (node)
  ((%left :initarg :left :accessor left)
   (%right :initarg :right :accessor right)))

(defclass 3-node (node)
  ((%left :initarg :left :accessor left)
   (%middle :initarg :middle :accessor middle)
   (%right :initarg :right :accessor right)))
