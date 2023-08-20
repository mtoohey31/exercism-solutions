(module
  ;; Returns 1 if leap year, 0 otherwise
  (func (export "isLeap") (param $year i32) (result i32)
    (if
      (i32.ne (i32.rem_u (local.get $year) (i32.const 4)) (i32.const 0))
      (then (return (i32.const 0))))
    (if
      (i32.eq (i32.rem_u (local.get $year) (i32.const 100)) (i32.const 0))
      (then
        (return
          (i32.eq
            (i32.rem_u (local.get $year) (i32.const 400))
            (i32.const 0)))))
    (return (i32.const 1)))  
)
