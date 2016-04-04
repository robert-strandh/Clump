(cl:in-package #:asdf-user)

(defsystem :clump-test
  :depends-on (:clump)
  :serial t
  :components
  ((:file "packages")
   (:file "node")
   (:file "print-object")
   (:file "fixup-parents")
   (:file "print-tree")
   (:file "make-complete-tree")
   (:file "random-tree")
   (:file "select-random-node")
   (:file "traverse")
   (:file "check-parents")
   (:file "test-rotation")
   (:file "test")
   (:file "test-splay")
   (:file "test-2-3-tree")))
