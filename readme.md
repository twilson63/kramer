# Kramer

A Javascript Object to XML Parser

# Install

`npm install kramer`

# Usage

``` javascript
var kramer = require('kramer');

var doc = {
  _: { version: '1', build: '2' },
  foo: {
    _: { cool: 'beans' },
    text: 'bar'
  }
}

var xml = kramer('root', doc);

console.log(xml);
```

# Results

``` 
<root version='1' build='2'>
  <foo cool="beans">bar</foo>
</root>
```


