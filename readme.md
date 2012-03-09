# Kramer

A Javascript Object to XML Parser

# Install

`npm install kramer`

# Usage

``` javascript
var kramer = require('kramer');

var doc = {
  _: { version: '1', build: '2' },
  foo: 'bar'
}

var xml = kramer.parse('root', doc);

console.log(xml);
```

# Results

``` 
<root version='1' build='2'>
  <foo>bar</foo>
</root>
```


