(cl:in-package #:clump-test)

(defmethod print-object ((object node-with-parent) stream)
  (print-unreadable-object (object stream :type t)
    (format stream "data: ~a" (data object))))
