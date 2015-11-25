(cl:in-package #:asdf-user)

(defsystem :clump-test
  :depends-on (:clump)
  :serial t
  :components
  ((:file "packages")))
