(cl:in-package #:common-lisp-user)

(defpackage #:clump-2-3-tree
  (:use #:common-lisp)
  (:shadow #:replace
	   #:delete)
  (:export #:tree
	   #:contents
	   #:leaf-class
	   #:2-node-class
	   #:3-node-class
	   #:leaf
	   #:2-node
	   #:3-node
	   #:left
	   #:right
	   #:middle
	   #:insert
	   #:insert-before
	   #:insert-after
	   #:split
	   #:replace
	   #:delete
	   #:delete-child))
