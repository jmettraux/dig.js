
//
// dig.js
//
// Tue Feb  4 09:06:07 JST 2025

window.D = function() {

  this.VERSION = '1.0.0';

  let dig = function(col, ks) {

    if (ks.length < 1) return col;

    if (col === null || col === undefined) return col;
    if (Array.isArray(col)) return dig(col[ks[0]], ks.slice(1));
    if (typeof col === 'object') return dig(col[ks[0]], ks.slice(1));
    return col;
  };

  let __makeDig = function(/* parent, name */) {

    let as = Array.from(arguments);

    let p = as.find(
      e => (e !== null) && (typeof e === 'object'));
    let n = as.find(
      e => (typeof e === 'string') || (Number.isInteger(e) && e >= 0));

    let funs = {

      __path: function() {
        return(
          this.__parent ? this.__parent.__path().concat(this.__name) :
          this.__name ?  [ this.__name ] :
          []); },
    };

    let rootFuns = {

      ig: function(col, key) {
        let ks =
          Number.isInteger(key) ? [ key ] :
          typeof key === 'string' ? [ key ] :
          key.__path();
        return dig(col, ks); },
    };

    let handler = {

      get: function(target, name) {
        //if (typeof name !== 'string') return undefined;
        if (name.match(/^-?\d+$/)) name = parseInt(name, 10);
        return(
          target.hasOwnProperty(name) ? target[name] :
          __makeDig(target, name)); }
    };

    let h = { __parent: p, __name: n };
      //
    Object.assign(h, funs);
    if ( ! p) Object.assign(h, rootFuns);

    return new Proxy(h, handler);
  };

  return __makeDig(); }();

//let n = h[D.customer.name]; // would need valueOf() and more :-(
//let n = D(h).customer.name;
//let n = D.customer.name.from(h);
//let n = D.customer.name.resolve(h);
//let n = D(h, D.customer.name);
//let n = D(h, e => e.customer.name);
  //
//let a = D.ig(h, D.customer.name);
//let b = D.ig(a, D[1].name);

