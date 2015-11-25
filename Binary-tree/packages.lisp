(cl:in-package #:common-lisp-user)

(defpackage #:clump-binary-tree
  (:use #:common-lisp)
  (:export #:node
	   #:simple-node
	   #:node-with-parent
	   #:left
	   #:right
	   #:parent
	   #:rotate-left
	   #:rotate-left-with-child
	   #:rotate-right
	   #:recursive-traversal
	   #:iterative-traversal
	   #:invalid-binary-tree
	   #:right-subtree-must-be-non-nil
	   #:left-subtree-must-be-non-nil))
