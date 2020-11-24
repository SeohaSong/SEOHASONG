let sum;
let size = 1000000;
const timePair = Array(2);
const idxs = Array(size);
const keys = Array(size);
for (let idx = 0; idx < size; idx++) idxs[idx] = idx;
for (let idx = 0; idx < size; idx++)
{
    let val = idx + '' + idx;
    keys[idx] = val;
}

console.log("array build time cost");
timePair[0] = new Date().getTime();
const arr = Array(size);
idxs.forEach((val, idx) => arr[val] = idx);
timePair[1] = new Date().getTime();
console.log(timePair[1] - timePair[0]);

console.log("dict build time cost");
timePair[0] = new Date().getTime();
const dict = {};
keys.forEach((val, idx) => dict[val] = idx);
timePair[1] = new Date().getTime();
console.log(timePair[1] - timePair[0]);

console.log("array get time cost");
timePair[0] = new Date().getTime();
sum = 0;
idxs.forEach(val => sum += arr[val]);
console.log(sum)
timePair[1] = new Date().getTime();
console.log(timePair[1] - timePair[0]);

console.log("dict get time cost");
timePair[0] = new Date().getTime();
sum = 0;
keys.forEach(val => sum += dict[val]);
console.log(sum)
timePair[1] = new Date().getTime();
console.log(timePair[1] - timePair[0]);

// array build time cost
// 14
// dict build time cost
// 680
// array get time cost
// 499999500000
// 26
// dict get time cost
// 499999500000
// 105
