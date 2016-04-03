(cl:in-package #:asdf-user)

(defsystem :clump-2-3-tree
  :depends-on (:acclimation)
  :serial t
  :components
  ((:file "packages")
   (:file "2-3-tree")
   (:file "insertion")
   (:file "deletion")
   (:file "conditions")))
