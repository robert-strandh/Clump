(cl:in-package #:common-lisp-user)

(defpackage #:clump-binary-tree
  (:use #:common-lisp)
  (:export #:node
	   #:left
	   #:right
	   #:rotate-left
	   #:rotate-right
	   #:invalid-binary-tree
	   #:right-subtree-must-be-non-nil
	   #:left-subtree-must-be-non-nil))
