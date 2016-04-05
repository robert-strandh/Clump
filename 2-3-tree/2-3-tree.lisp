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
  ((%left :initarg :left :reader left :writer (setf %left))
   (%right :initarg :right :reader right :writer (setf %right))))

(defmethod initialize-instance :after ((node 2-node) &key)
  (setf (parent (left node)) node
	(parent (right node)) node))

(defgeneric 2-node-p (object)
  (:method (object) nil)
  (:method ((node 2-node)) t))

(defclass 3-node (node)
  ((%left :initarg :left :reader left :writer (setf %left))
   (%middle :initarg :middle :reader middle :writer (setf %middle))
   (%right :initarg :right :reader right :writer (setf %right))))

(defmethod initialize-instance :after ((node 3-node) &key)
  (setf (parent (left node)) node
	(parent (middle node)) node
	(parent (right node)) node))

(defgeneric 3-node-p (object)
  (:method (object) nil)
  (:method ((node 3-node)) t))
