(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(define (pow x y)
  (cond ((= y 0) 1)
        ((= y 1) x)
        (else (* x (pow x (- y 1))))))

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (k n) (A 2 n))


;;iterate fib
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0))
         0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;;;recur process
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(define (g n)
  (g-iter 0 1 2 n))

(define (g-iter a b c n)
  (cond ((< n 3) n)
        ((= n 3) (+ (* 3 a) (* 2 b) c))
        (else (g-iter b c (+ (* 3 a) (* 2 b) c) (- n 1)))))

(define (square x)
  (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (new-fast-expt b n)
  (if (= n 0)
      1
      (ii b 1 n)))

(define (square x)
  (* x x))

(define (ii b a n)
  (cond ((= n 1) a)
        ((even? n) (ii b (* a (square b)) (/ n 2)))
        (else (ii b (* a b) (- n 1)))))