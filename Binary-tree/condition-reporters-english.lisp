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
