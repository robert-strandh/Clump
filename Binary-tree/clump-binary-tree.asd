(cl:in-package #:asdf-user)

(defsystem :clump-binary-tree
  :serial t
  :components
  ((:file "packages")
   (:file "binary-tree")
   (:file "docstrings-english")))
