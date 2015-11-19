(cl:in-package #:clump-binary-tree)

(setf (documentation 'left 'function)
      (format nil "Given a binary tree, return the left child of that tree.~@
                   If an object other than a binary tree is given,~@
                   then an error of type INVALID-BINARY-TREE is signaled."))

(setf (documentation 'right 'function)
      (format nil "Given a binary tree, return the right child of that tree.~@
                   If an object other than a binary tree is given,~@
                   then an error of type INVALID-BINARY-TREE is signaled."))

(setf (documentation '(setf left) 'function)
      (format nil "Given two binary trees, NEW and TREE,~@
                   make NEW the new left child of TREE.~@
                   NEW may be a node or NIL.~@
                   If TREE is NIL an error of type,~@
                   INVALID-BINARY-TREE is signaled."))

(setf (documentation '(setf right) 'function)
      (format nil "Given two binary trees, NEW and TREE,~@
                   make NEW the new right child of TREE.~@
                   NEW may be a node or NIL.~@
                   If TREE is NIL an error of type,~@
                   INVALID-BINARY-TREE is signaled."))

(setf (documentation 'rotate-left 'function)
      (format nil "Given a binary tree TREE, apply a left rotation to it.~@
                   If TREE is not a node, an error of type,~@
                   INVALID-BINARY-TREE is signaled.~@
                   If the right child of TREE is not a node, an error of type~@
                   RIGHT-SUBTREE-MUST-BE-NON-NIL is signaled.~@
                   The new root of the tree is returned.~@
                   If TREE has a parent node, no provision is made~@
                   for replacing TREE with the return value of this function.~@
                   Client code is responsible for doing that."))

(setf (documentation 'rotate-right 'function)
      (format nil "Given a binary tree TREE, apply a right rotation to it.~@
                   If TREE is not a node, an error of type,~@
                   INVALID-BINARY-TREE is signaled.~@
                   If the left child of TREE is not a node, an error of type~@
                   LEFT-SUBTREE-MUST-BE-NON-NIL is signaled.~@
                   The new root of the tree is returned.~@
                   If TREE has a parent node, no provision is made~@
                   for replacing TREE with the return value of this function.~@
                   Client code is responsible for doing that."))
