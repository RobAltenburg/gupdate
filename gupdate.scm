(use srfi-1 posix)

(define (update-directory thunk dir)
  (unless (null? dir)
      (change-directory (car dir))
      (thunk)
      (update-directory thunk (append (cdr dir)
          (map (lambda (x) 
                 (string-append (current-directory) "/" x)) 
                    (filter directory? (directory (current-directory))))))))
      
(define (git-update-dir)
    (when (file-exists? ".git")
      (format #t "In: ~A~%" (current-directory))  
      (system "git pull")
      (newline)))

(let ((dirlist (command-line-arguments)))
  (if (null? dirlist)
  (fmt #t "Usage:  gupdate <directory>" nl 
       "Runs \"git pull\" in the directory and any git repositories in subdirectories." nl)
    (update-directory git-update-dir dirlist)))
                  

