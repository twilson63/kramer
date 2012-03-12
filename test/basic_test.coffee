kramer = require '../lib'
describe 'kramer js to xml', ->
  it 'should parse this simple example', ->
    doc = 
      foo: 'bar'
    xml = kramer 'root', doc
    xml.should.equal "<root><foo>bar</foo></root>"
  it 'should parse multiple nodes', ->
    doc =
      foo: 'bar'
      bar: 'foo'
    xml = kramer 'root', doc
    xml.should.equal "<root><foo>bar</foo><bar>foo</bar></root>"
  it 'should parse attributes from underscore', ->
    doc =
      _: { version: '1' }
      foo: 'bar'
    xml = kramer 'root', doc
    xml.should.equal "<root version=\"1\"><foo>bar</foo></root>"
  it "should parse multiple attributes", ->
    doc = 
      _: { version: '1', build: '6' }
      foo: 'bar'
      bar: 'foo'
    xml = kramer 'root', doc
    xml.should.equal "<root version=\"1\" build=\"6\"><foo>bar</foo><bar>foo</bar></root>"

  it "should parse multiple attributes", ->
    doc = 
      _: { version: '1', build: '6' }
      text: 'bar'
    xml = kramer 'root', doc
    xml.should.equal "<root version=\"1\" build=\"6\">bar</root>"
