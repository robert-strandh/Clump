(cl:in-package #:asdf-user)

(defsystem clump
  :description "Library for operations on different kinds of trees"
  :author "Robert Strandh <robert.strandh@gmail.com>"
  :license "FreeBSD, see file LICENSE.text"
  :depends-on (:clump-binary-tree))
