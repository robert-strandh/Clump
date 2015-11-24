(cl:in-package #:asdf-user)

(defsystem :clump-binary-tree
  :depends-on (:acclimation)
  :serial t
  :components
  ((:file "packages")
   (:file "binary-tree")
   (:file "conditions")
   (:file "rotation")
   (:file "iterative-traversal")
   (:file "docstrings-english")
   (:file "condition-reporters-english")))
