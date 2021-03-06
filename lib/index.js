var attr, node, parseAttr, parseNode;
var __hasProp = Object.prototype.hasOwnProperty;

attr = function(attributes) {
  var key, value, xmlAttributes;
  xmlAttributes = " ";
  for (key in attributes) {
    if (!__hasProp.call(attributes, key)) continue;
    value = attributes[key];
    xmlAttributes += "" + key + "=\"" + value + "\" ";
  }
  return xmlAttributes;
};

node = function(key, value, attributes) {
  if (key.match(/(text)|(Text)/)) {
    return value;
  } else {
    return "<" + key + (attributes != null ? attributes.replace(/\s+$/, '') : '') + ">" + value + "</" + key + ">";
  }
};

parseAttr = function(key, value) {
  var attributes;
  if (typeof value === 'object') {
    if (value['_'] != null) attributes = attr(value['_']);
  }
  return attributes;
};

parseNode = function(data) {
  var attributes, k, v, xmlDoc;
  xmlDoc = "";
  if (typeof data === 'object') {
    for (k in data) {
      if (!__hasProp.call(data, k)) continue;
      v = data[k];
      attributes = parseAttr(k, v);
      if (k !== '_') xmlDoc += node(k, parseNode(v), attributes);
    }
  } else {
    xmlDoc = data;
  }
  return xmlDoc;
};

module.exports = function(root, doc) {
  var attributes;
  attributes = parseAttr(root, doc);
  return node(root, parseNode(doc), attributes);
};
