(module
  ;; The name prefixed with $ is used to internally refer to functions via the call instruction
  ;; The string in the export instruction is the name of the export made available to the
  ;; embedding environment (in this case, Node.js). This is used by our test runner Jest.
  (func $squareOfSum (export "squareOfSum") (param $max i32) (result i32)
    (local $sum i32)
    ;; $sum = ($max * ($max - 1)) / 2
    (local.set $sum
      (i32.div_u
        (i32.mul (local.get $max) (i32.add (local.get $max) (i32.const 1)))
        (i32.const 2)))
    ;; return $sum * $sum
    (return (i32.mul (local.get $sum) (local.get $sum))))

  (func $sumOfSquares (export "sumOfSquares") (param $max i32) (result i32)
    ;; return ($max * ($max + 1) * (2 * $max + 1)) / 6
    (return
      (i32.div_u
        (i32.mul
          (local.get $max)
          (i32.mul
            (i32.add (local.get $max) (i32.const 1))
            (i32.add (i32.mul (i32.const 2) (local.get $max)) (i32.const 1))))
        (i32.const 6))))

  (func (export "difference") (param $max i32) (result i32)
    (return
      (i32.sub
        (call $squareOfSum (local.get $max))
        (call $sumOfSquares (local.get $max)))))
)
