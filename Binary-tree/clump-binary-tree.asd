(cl:in-package #:asdf-user)

(defsystem :clump-binary-tree
  :depends-on (:acclimation)
  :serial t
  :components
  ((:file "packages")
   (:file "binary-tree")
   (:file "conditions")
   (:file "replace-child")
   (:file "rotation")
   (:file "recursive-traversal")
   (:file "iterative-traversal")
   (:file "splay")
   (:file "docstrings-english")
   (:file "condition-reporters-english")))
