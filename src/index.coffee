# # attr
#
# private function that creates attributes for xml document
#
attr = (attributes) ->
  xmlAttributes = " "
  xmlAttributes += "#{key}=\"#{value}\" " for own key, value of attributes
  xmlAttributes

# # node
#
# private function that create a node for an xml document
#
# ## parameters
#
# name      |   type          | description
# ----------|-----------------|------------------------
# key       | string          | node name of xml node
# value     | object/string   | value of xml node
# attributes| string/optional| attributes for a given node
node = (key, value, attributes) -> 
  if key.match /(text)|(Text)/
    value
  else
    "<#{key}#{if attributes? then attributes.replace(/\s+$/, '') else ''}>#{value}</#{key}>"

parseAttr = (key, value) ->
  if typeof value is 'object'
    if value['_']?
      attributes = attr value['_']
  attributes

parseNode = (data) ->
  xmlDoc = ""
  if typeof data is 'object'
    #delete data['_'] # remove attr key
    for own k,v of data
      attributes = parseAttr(k, v) 
      xmlDoc += node(k, parseNode(v), attributes) unless k == '_'
  else
    xmlDoc = data
  xmlDoc

# # kramer
# 
# converts a javascript object to xml
#
# ##attributes
# 
# attribute   |   description
# ------------|----------------------
# root        | root node for the xml document
# doc         | javascript object that is the body of the xml doc
# 
# ## returns
# 
# `xmldocument as string`
#
module.exports = (root, doc) ->
    attributes = parseAttr(root, doc)
    node root, parseNode(doc), attributes

