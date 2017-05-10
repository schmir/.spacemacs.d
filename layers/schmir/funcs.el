(defun schmir/find-alternate-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (let ((my-point (point)))
      (find-alternate-file
       (concat "/root@localhost:"
               buffer-file-name))
      (goto-char my-point))
    (message buffer-file-name)))
