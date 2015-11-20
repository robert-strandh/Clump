(cl:in-package #:asdf-user)

(defsystem :clump-splay-tree
  :depends-on (:clump-binary-tree)
  :serial t
  :components
  ((:file "packages")))
