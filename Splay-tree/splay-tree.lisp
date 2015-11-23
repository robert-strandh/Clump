(cl:in-package #:clump-splay-tree)

(defgeneric splay-step-with-parent (node parent))

(defgeneric splay-step (node))

(defgeneric splay (node))
