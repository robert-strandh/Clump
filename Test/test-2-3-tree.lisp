(cl:in-package #:clump-test)

(defclass size-mixin ()
  ((%size :initarg :size :accessor size)))

(defmethod clump-2-3-tree:replace :after
    ((node size-mixin) old-child new-child)
  (declare (ignore old-child new-child))
  (recompute-size node))

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

(defmethod clump-2-3-tree:replace-and-shrink :after
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

(defmethod clump-2-3-tree:replace-and-shrink :after
    ((node 3-node-size) old-child new-child)
  (declare (ignore old-child new-child))
  (recompute-size node))

(defclass size-tree (clump-2-3-tree:tree)
  ()
  (:default-initargs
   :leaf-class 'leaf-size
   :2-node-class '2-node-size
   :3-node-class '3-node-size))

(defgeneric find-leaf (node-or-tree leaf-number))

(defmethod find-leaf ((tree size-tree) leaf-number)
  (let ((contents (clump-2-3-tree:contents tree)))
    (assert (not (null contents)))
    (find-leaf contents leaf-number)))

(defmethod find-leaf ((node leaf-size) leaf-number)
  (assert (zerop leaf-number))
  node)

(defmethod find-leaf ((node 2-node-size) leaf-number)
  (let ((left (clump-2-3-tree:left node))
	(right (clump-2-3-tree:right node)))
    (if (< leaf-number (size left))
	(find-leaf left leaf-number)
	(find-leaf right (- leaf-number (size left))))))

(defmethod find-leaf ((node 3-node-size) leaf-number)
  (let ((left (clump-2-3-tree:left node))
	(middle (clump-2-3-tree:middle node))
	(right (clump-2-3-tree:right node)))
    (cond ((< leaf-number (size left))
	   (find-leaf left leaf-number))
	  ((< leaf-number (+ (size left) (size middle)))
	   (find-leaf middle (- leaf-number (size left))))
	  (t
	   (find-leaf right (- leaf-number (+ (size left) (size middle))))))))

(defgeneric to-list (node-or-tree))

(defmethod to-list ((tree size-tree))
  (let ((contents (clump-2-3-tree:contents tree)))
    (if (null contents)
	'()
	(to-list contents))))

(defmethod to-list ((node leaf-size))
  (list (clump-2-3-tree:contents node)))

(defmethod to-list ((node 2-node-size))
  (append (to-list (clump-2-3-tree:left node))
	  (to-list (clump-2-3-tree:right node))))

(defmethod to-list ((node 3-node-size))
  (append (to-list (clump-2-3-tree:left node))
	  (to-list (clump-2-3-tree:middle node))
	  (to-list (clump-2-3-tree:right node))))

(defun test-2-3-tree-1 (n)
  (let ((operation :insert)
	(list '())
	(tree (make-instance 'size-tree)))
    (flet ((insert-before (position)
	     (let ((neighbor (find-leaf tree position))
		   (element (random 1000000000)))
	       (clump-2-3-tree:insert-before element neighbor)
	       (setf list
		     (append (subseq list 0 position)
			     (list element)
			     (subseq list position)))))
	   (insert-after (position)
	     (let ((neighbor (find-leaf tree position))
		   (element (random 1000000000)))
	       (clump-2-3-tree:insert-after element neighbor)
	       (setf list
		     (append (subseq list 0 (1+ position))
			     (list element)
			     (subseq list (1+ position)))))))
      (loop repeat n
	    do (when (< (random 1d0) 1d-1)
		 (setf operation
		       (if (eq operation :insert)
			   :delete
			   :insert)))
	       (if (or (eq operation :insert) (null list))
		   (if (null list)
		       (let ((element (random 1000000000)))
			 (setf list (list element))
			 (clump-2-3-tree:insert element tree))
		       (let ((position (random (1+ (length list)))))
			 (cond ((zerop position)
				(insert-before 0))
			       ((= position (length list))
				(insert-after (1- (length list))))
			       ((< (random 1d0) 0.5d0)
				(insert-before position))
			       (t
				(insert-after (1- position))))))
		   (let* ((position (random (length list)))
			  (leaf (find-leaf tree position)))
		     (clump-2-3-tree:delete leaf)
		     (setf list
			   (append (subseq list 0 position)
				   (subseq list (1+ position))))))))))
