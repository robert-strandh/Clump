(cl:in-package #:asdf-user)

(defsystem :clump-test
  :depends-on (:clump)
  :serial t
  :components
  ((:file "packages")
   (:file "node")
   (:file "fixup-parents")
   (:file "print-tree")
   (:file "random-tree")
   (:file "select-random-node")
   (:file "traverse")
   (:file "test")
   (:file "test-splay")))
