(module
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $dist f32)
    (local.set $dist
      (f32.sqrt
        (f32.add
          (f32.mul (local.get $x) (local.get $x))
          (f32.mul (local.get $y) (local.get $y)))))
    (if (f32.gt (local.get $dist) (f32.const 10))
      (then (return (i32.const 0))))
    (if (f32.gt (local.get $dist) (f32.const 5))
      (then (return (i32.const 1))))
    (if (f32.gt (local.get $dist) (f32.const 1))
      (then (return (i32.const 5))))
    (return (i32.const 10)))
)
