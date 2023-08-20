(module
  ;; $number is signed
  ;; $result is unsigned
  (func $steps (export "steps") (param $number i32) (result i32)
    (local $next i32)
    ;; Zero or negative is an error
    (if (i32.le_s (local.get $number) (i32.const 0))
      (then (return (i32.const -1))))
    ;; If we're at 1 then we're done with no more steps
    (if (i32.eq (local.get $number) (i32.const 1))
      (then (return (i32.const 0))))
    (if
      ;; Check even/odd
      (i32.eq
        (i32.rem_s (local.get $number) (i32.const 2))
        (i32.const 0))
      ;; If even, next is the $number/2
      (then (local.set $next (i32.div_s (local.get $number) (i32.const 2))))
      ;; If odd, next is 3$number+1
      (else
        (local.set $next
          (i32.add
            (i32.mul (i32.const 3) (local.get $number))
            (i32.const 1)))))
    ;; $result is 1+$steps($next)
    (i32.add (i32.const 1) (call $steps (local.get $next))))
)