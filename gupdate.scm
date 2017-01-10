(use posix)

(define start-directory "/Users/rca/.vim/bundle")

(define process-subdirectory
  (lambda (d)
         (if (directory? d)
           (begin
             (change-directory d)
             (format #t "~%In dir: ~A..." (current-directory))
             (if (file-exists? ".git")
                (system "git pull")
                (write "no go"))
             (change-directory "..")
             )
           '())))

(define process-directories 
  (lambda (d)
     (if (null? d)
        (write "done")
        (let ([dw (car d)])
           (process-subdirectory dw)
           (process-directories (cdr d)))
        )))

(change-directory start-directory)
(process-directories (directory start-directory))

