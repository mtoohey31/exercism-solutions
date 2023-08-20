(module
  ;; squareNum is signed
  ;; Result is unsigned
  (func $square (export "square") (param $squareNum i32) (result i64)
    ;; First check for <=0
    (if
      (i32.le_s (local.get $squareNum) (i32.const 0))
      (then (return (i64.const 0))))
    ;; Then for >64
    (if
      (i32.gt_s (local.get $squareNum) (i32.const 64))
      (then (return (i64.const 0))))
    ;; Otherwise the result is 1<<($squareNum-1)
    (return
      (i64.shl
        (i64.const 1)
        (i64.sub (i64.extend_i32_u (local.get $squareNum)) (i64.const 1))))
  )

  ;; Result is unsigned
  (func (export "total") (result i64)
    ;; Use overflow to create i64 with all bits set
    (i64.sub (i64.const 0) (i64.const 1))
  )
)
