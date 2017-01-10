(use srfi-1 fmt posix)

(define (update-directory thunk dir)
  (if (null? dir)
    #t
    (let ((old-dir (current-directory))
          (proc-dir (car dir)))
      (change-directory proc-dir)
      (thunk)
      (update-directory thunk (filter directory? (directory (current-directory))))
      (change-directory old-dir)
      (update-directory thunk (cdr dir)))))

(define (git-update-dir)
    (when (file-exists? ".git")
      (fmt #t "In: " (current-directory) nl)  
      (system "git pull")
      (fmt #t nl)))

(define start-directory "~/.vim/bundle")
(change-directory start-directory)
(update-directory git-update-dir (directory start-directory))
                  

