;;;; gupdate
; 
; a program to run "git pull" in a series of subdirectories
; Right now it does not descend recursively to nested subdirectories
; but the "levels" variable is there to make that an option
;

(import srfi-1
        shell
        (chicken process)
        (chicken process-context)
        (chicken file)
        (chicken format)
        (chicken file posix))

(define (full-directory #!optional (pathname (current-directory)))
    (map (lambda (dd)
           (string-append pathname "/" dd)) (directory pathname)))

(define (process-directory start-dir in-dir levels) 
  (change-directory in-dir)
  (printf "Checking ~A~%" in-dir) 
  (when (file-exists? ".git")
    (system "git pull")
    )
  (change-directory start-dir))

(define (select-directories #!optional (start-directory (current-directory)) (number-of-levels 1))
  (let ((sub-directories (filter directory? (full-directory start-directory))))
    (map (lambda (dd)
           (process-directory start-directory dd number-of-levels)) sub-directories)))

(let ((args (command-line-arguments)))
  (if (null? args)
      (select-directories)
      (select-directories (car (reverse args)) 1)))

