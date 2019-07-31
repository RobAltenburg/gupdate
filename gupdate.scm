;;;; gupdate
; 
; a program to run "git pull" in a series of subdirectories
;
;

(import srfi-1
        shell
        (chicken process)
        (chicken process-context)
        (chicken file)
        (chicken format)
        (chicken file posix))

(define (process-directory start-dir in-dir levels) 
  (change-directory in-dir)
  (printf "in directory ~A~%" in-dir) 
  (when (file-exists? ".git")
    (print "Found git")
    (system "git pull")
    )
  (change-directory start-dir))

(define (select-directories #!optional (start-directory (current-directory)) (number-of-levels 1))
  (print "Running in " start-directory)
  (print "Levels: " number-of-levels)
  (let ((sub-directories (filter directory? (directory start-directory))))
    (map (lambda (dd)
           (process-directory start-directory dd number-of-levels)) sub-directories)))

(select-directories)

