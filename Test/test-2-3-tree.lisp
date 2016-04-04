(cl:in-package #:clump-test)

(defclass size-mixin ()
  ((%size :initarg :size :accessor size)))

(defclass leaf-size (size-mixin clump-2-3-tree:leaf)
  ()
  (:default-initargs :size 1))

(defclass 2-node-size (size-mixin clump-2-3-tree:2-node)
  ())

(defgeneric recompute-size (node))

(defmethod recompute-size ((node 2-node-size))
  (setf (size node)
	(+ (size (clump-2-3-tree:left node))
	   (size (clump-2-3-tree:right node)))))

(defmethod initialize-instance :after ((object 2-node-size) &key)
  (recompute-size object))

(defmethod clump-2-3-tree:replace :after
    ((node 2-node-size) old-child new-child)
  (declare (ignore old-child new-child))
  (recompute-size node))

(defclass 3-node-size (size-mixin clump-2-3-tree:3-node)
  ())

(defmethod recompute-size ((node 3-node-size))
  (setf (size node)
	(+ (size (clump-2-3-tree:left node))
	   (size (clump-2-3-tree:middle node))
	   (size (clump-2-3-tree:right node)))))

(defmethod initialize-instance :after ((object 3-node-size) &key)
  (recompute-size object))

(defclass size-tree (clump-2-3-tree:tree)
  ()
  (:default-initargs
   :2-node-class '2-node-size
   :3-node-class '3-node-size))
