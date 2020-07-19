## 1.
> Below two things are same operations.
```bash
test $expression
[ $expression ]
```

## 2.
> These is shell built-in.
```bash
test 1 == 1 -o 1 == 2
[ 1 == 1 -o 1 == 2 ]
```
> This opration is bash's extension.
```bash
[[ ( $condition || $condition ) && 2 > 1 ]]
```

## 3.
> Below two things are just built-in operation which return 0 or 1.
```bash
if true; then echo 1; fi
# 1
if ( return 0 ); then echo 1; fi
# 1
```

## 4.
> '$?' keyword indicate the latest operation return number.
```bash
true && ( echo $?; false ) || echo $?;
# 0
# 1
false && ( echo $?; false ) || echo $?;
# 1
```

## 5.
> 'if' keyword consider '$?' indicating number when encountered ';'.
```bash
if false && true; then echo 1; fi
#
```

## 6. 
> 'trap' keyword consider only latest operation return number
> when encountered ';'.
```bash
trap "echo !!" ERR
```
```bash
false && true
#
true && false
# !!
( false && true )
# !!
```