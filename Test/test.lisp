(cl:in-package #:clump-test)

(defun test1 ()
  (loop with r = #'clump-binary-tree:recursive-traversal
	with i = #'clump-binary-tree:iterative-traversal
	repeat 10000
	for tree = (random-tree 'node-with-parent)
	do (fixup-parents tree)
	   (assert (tree-equal (traverse tree r) (traverse tree i)))))

(defun test2 ()
  (loop with r = #'clump-binary-tree:recursive-traversal
	with i = #'clump-binary-tree:iterative-traversal
	repeat 10000
	for tree = (random-tree 'simple-node)
	do (assert (tree-equal (traverse tree r) (traverse tree i)))))
