(function() {
  var attr, node, parseAttr, parseNode;

  attr = function(attributes) {
    var key, value, xmlAttributes;
    xmlAttributes = " ";
    for (key in attributes) {
      value = attributes[key];
      xmlAttributes += "" + key + "=\"" + value + "\" ";
    }
    return xmlAttributes;
  };

  node = function(key, value, attributes) {
    return "<" + key + (attributes != null ? attributes.replace(/\s+$/, '') : '') + ">" + value + "</" + key + ">";
  };

  parseAttr = function(key, value) {
    var attributes;
    if (typeof value === 'object') {
      if (value['_'] != null) attributes = attr(value['_']);
    }
    return attributes;
  };

  parseNode = function(data) {
    var k, v, xmlDoc;
    xmlDoc = "";
    if (typeof data === 'object') {
      delete data['_'];
      for (k in data) {
        v = data[k];
        xmlDoc += node(k, parseNode(v), parseAttr(k, v));
      }
    } else {
      xmlDoc = data;
    }
    return xmlDoc;
  };

  module.exports = {
    parse: function(root, doc) {
      var attributes;
      attributes = parseAttr(root, doc);
      return node(root, parseNode(doc), attributes);
    }
  };

}).call(this);
