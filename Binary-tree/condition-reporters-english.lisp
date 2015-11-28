(cl:in-package #:clump-binary-tree)

(defmethod acclimation:report-condition
    ((condition invalid-binary-tree)
     stream
     (language acclimation:english))
  (format stream
	  "A binary tree was expected,~@
           but instead the following was found:~@
           ~s"
	  (tree condition)))

(defmethod acclimation:report-condition
    ((condition right-subtree-must-be-non-nil)
     stream
     (language acclimation:english))
  (format stream
	  "The right subtree of the following tree,~@
           is NIL, but a non-NIL subtree is required:~@
           ~s"
	  (tree condition)))

(defmethod acclimation:report-condition
    ((condition left-subtree-must-be-non-nil)
     stream
     (language acclimation:english))
  (format stream
	  "The left subtree of the following tree,~@
           is NIL, but a non-NIL subtree is required:~@
           ~s"
	  (tree condition)))

(defmethod acclimation:report-condition
    ((condition must-be-child)
     stream
     (language acclimation:english))
  (format stream
	  "The node:~@
           ~s~@
           must be a child of the node:
           ~s~@
           but this is not the case."
	  (child condition)
	  (tree condition)))
