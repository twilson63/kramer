attr = (attributes) ->
  xmlAttributes = " "
  xmlAttributes += "#{key}=\"#{value}\" " for key, value of attributes
  xmlAttributes
node = (key, value, attributes) -> 
  "<#{key}#{if attributes? then attributes.replace(/\s+$/, '') else ''}>#{value}</#{key}>"

parseAttr = (key, value) ->
  if typeof value is 'object'
    if value['_']?
      attributes = attr value['_']
  attributes

parseNode = (data) ->
  xmlDoc = ""
  if typeof data is 'object'
    delete data['_'] # remove attr key
    for k,v of data
      xmlDoc += node k, parseNode(v), parseAttr(k, v)
  else
    xmlDoc = data
  xmlDoc

module.exports = (root, doc) ->
    attributes = parseAttr(root, doc)
    node root, parseNode(doc), attributes

