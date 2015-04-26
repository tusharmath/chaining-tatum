Chaining Tatum
---

A utility library that assists in method chaining of async functions. Mixing async with sync method especially when they are being called serially results in a very verbose code. There are unecessary callbacks and overuse of the `then` method.

##Example

```js
var baseUrl = 'http://www.product.com/'

//Returns a value
var sum = function (a, b){
    return a + b;
}


//Returns a promise, that resolves into the product of two numbers
var product = function (a, b){
    return http.get(baseUrl + a + '/' +b);
}

```

There are two functions `sum` and `product`. The sum instantly adds the two arguments and returns a value where as product makes an async http request to get the product of two numbers.

###Usage without chaining-tatum

```js
var startValue = 10,
    finalValue;

var a = sum(startValue, 20);

product(a, 100)
    .then(function (productWith100){
        return sum(50, productWith100);
    })
    .then(function (sumWith50){
        return product(1000, sumWith50);
    })
    .then(function(productWith1000){
        finalValue = productWith1000;
    });
```

###Usage with chaining-tatum
```js
var Chain = require('chaining-tatum').Chain;

//Create a prototype object
var proto = {
    sum: sum,
    product: product
}

var chained = new Chain(proto);

chained
    .sum(20) //sum(10, 20) := 30
    .product(100) //product(100, 30) := 130 as a promise
    .sum(50)
    .product(1000)
    .$launch(startValue)
    .then(function(value){
        finalValue = value;
    });
```

The execution doesn't happen until the `$launch` method is called with some `initial value`. The initial value is set into the memory and is used as the `second parameter` to the `sum` method, first being the value `20`. The value is calculated by calling the sum method and then is passed as the second argument to the `product` method, first being 100 in this case.

product method returns a promise, only when that is resolved it is passed to the next `sum` method call with `50` as the second param and `130` as the first param.

This makes the code much more readable and one doesn't need to know if the function returns a promise or not.

Not Happy? Create a [ticket](https://github.com/tusharmath/chaining-tatum/issues/new).
