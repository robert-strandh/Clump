(cl:in-package #:clump-splay-tree)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP-WITH-LEFT-PARENT.
;;;
;;; This function is called to apply a splay step to a NODE and its
;;; PARENT when it is known that NODE is the RIGHT child of PARENT.

(defgeneric splay-step-with-left-parent (node parent))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function SPLAY-STEP.
;;;
;;; This function takes a NODE and applies a single splay step to that
;;; node.

(defgeneric splay-step (node))

(defmethod splay-step ((node clump-binary-tree:node-with-parent))
  (let ((parent (clump-binary-tree:parent node)))
    (unless (null parent)
      (splay-step-with-parent node parent)))
  node)

(defgeneric splay (node))
