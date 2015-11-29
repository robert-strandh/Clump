(cl:in-package #:clump-binary-tree)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-LEFT-PARENT-AND-LEFT-GRANDPARENT.
;;;
;;; This function is called to apply a splay step to a NODE, the
;;; PARENT of NODE, and the GRANDPARENT of NODE when it is known that
;;; NODE is the RIGHT child of PARENT and PARENT is the RIGHT child of
;;; GRANDPARENT.

(defgeneric splay-step-with-left-parent-and-left-grandparent
    (node parent grandparent))

(defmethod splay-step-with-left-parent-and-left-grandparent
    ((node node-with-parent)
     (parent node-with-parent)
     (grandparent node-with-parent))
  (rotate-left grandparent)
  (rotate-left parent)
  node)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-LEFT-PARENT-AND-RIGHT-GRANDPARENT.
;;;
;;; This function is called to apply a splay step to a NODE, the
;;; PARENT of NODE, and the GRANDPARENT of NODE when it is known that
;;; NODE is the RIGHT child of PARENT and PARENT is the LEFT child of
;;; GRANDPARENT.

(defgeneric splay-step-with-left-parent-and-right-grandparent
    (node parent grandparent))

(defmethod splay-step-with-left-parent-and-right-grandparent
    ((node node-with-parent)
     (parent node-with-parent)
     (grandparent node-with-parent))
  (rotate-left parent)
  (rotate-right grandparent)
  node)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-RIGHT-PARENT-AND-RIGHT-GRANDPARENT.
;;;
;;; This function is called to apply a splay step to a NODE, the
;;; PARENT of NODE, and the GRANDPARENT of NODE when it is known that
;;; NODE is the LEFT child of PARENT and PARENT is the LEFT child of
;;; GRANDPARENT.

(defgeneric splay-step-with-right-parent-and-right-grandparent
    (node parent grandparent))

(defmethod splay-step-with-right-parent-and-right-grandparent
    ((node node-with-parent)
     (parent node-with-parent)
     (grandparent node-with-parent))
  (rotate-right grandparent)
  (rotate-right parent)
  node)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-RIGHT-PARENT-AND-LEFT-GRANDPARENT.
;;;
;;; This function is called to apply a splay step to a NODE, the
;;; PARENT of NODE, and the GRANDPARENT of NODE when it is known that
;;; NODE is the LEFT child of PARENT and PARENT is the RIGHT child of
;;; GRANDPARENT.

(defgeneric splay-step-with-right-parent-and-left-grandparent
    (node parent grandparent))

(defmethod splay-step-with-right-parent-and-left-grandparent
    ((node node-with-parent)
     (parent node-with-parent)
     (grandparent node-with-parent))
  (rotate-right parent)
  (rotate-left grandparent)
  node)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-LEFT-PARENT-AND-GRANDPARENT.

(defgeneric splay-step-with-left-parent-and-grandparent
  (node parent grandparent))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-LEFT-PARENT.
;;;
;;; This function is called to apply a splay step to a NODE and its
;;; PARENT when it is known that NODE is the RIGHT child of PARENT.

(defgeneric splay-step-with-left-parent (node parent))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-RIGHT-PARENT.
;;;
;;; This function is called to apply a splay step to a NODE and its
;;; PARENT when it is known that NODE is the LEFT child of PARENT.

(defgeneric splay-step-with-right-parent (node parent))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-PARENT.
;;;
;;; This function should not be called directly by client code.  It is
;;; called by the function SPLAY-STEP with the NODE to splay and the
;;; PARENT of NODE, only when PARENT is not NIL.
;;;
;;; Client code can define methods on this generic function.  Such
;;; methods may be specialized to strict subclasses of the class
;;; NODE-WITH-PARENT.
;;;
;;; This function returns NODE as a single value.

(defgeneric splay-step-with-parent (node parent))

(defmethod splay-step-with-parent ((node node-with-parent)
				   (parent node-with-parent))
  (if (eq node (left parent))
      (splay-step-with-right-parent node parent)
      (splay-step-with-left-parent node parent)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP.
;;;
;;; This function takes a NODE and applies a single splay step to that
;;; node.

(defgeneric splay-step (node))

(defmethod splay-step ((node node-with-parent))
  (let ((parent (parent node)))
    (unless (null parent)
      (splay-step-with-parent node parent)))
  node)

(defgeneric splay (node))

(defmethod splay ((node node-with-parent))
  (loop until (null (parent node))
	do (splay-step node))
  node)
