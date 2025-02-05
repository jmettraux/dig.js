
# dig.js

Some kind of `D.ig`

```javascript
let h = { customer: { name: 'toto', age: 33 } };
D.ig(h, D.customer.name);
  // => 'toto'

let a = [ 1, 2, 3, { customer: 'surfdude' }, 'five' ];
D.ig(a, D[3].customer) ?? 'noone';
  // => 'surfdude'
D.ig(a, D[3].user) ?? 'noone';
  // => 'noone'
```

## LICENSE

MIT, see [LICENSE.txt](LICENSE.txt)

