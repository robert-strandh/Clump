(cl:in-package #:clump-binary-tree)

(setf (documentation 'left 'function)
      (format nil "Given a binary tree, return the left child of that tree.~@
                   If an object other than a binary tree is given,~@
                   then an error of type INVALID-BINARY-TREE is signaled."))

(setf (documentation 'right 'function)
      (format nil "Given a binary tree, return the right child of that tree.~@
                   If an object other than a binary tree is given,~@
                   then an error of type INVALID-BINARY-TREE is signaled."))
