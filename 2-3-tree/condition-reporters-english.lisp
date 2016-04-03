(cl:in-package #:clump-2-3-tree)

(defmethod acclimation:report-condition
    ((condition tree-for-insertion-must-be-empty)
     stream
     (language acclimation:english))
  (format stream
	  "Insertion directly in a 2-3 tree~@
           requires an empty tree,~@
           but instead the following was found:~@
           ~s"
	  (tree condition)))
