// Generated by CoffeeScript 1.9.3
var Line, Prompt, Terminal,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Line = require("./Line");

Prompt = require("./Prompt");

require("./style/Terminal.scss");

Terminal = (function(superClass) {
  extend(Terminal, superClass);

  function Terminal() {
    return Terminal.__super__.constructor.apply(this, arguments);
  }

  Terminal.prototype.componentDidUpdate = function() {
    return this.setScrollPosition();
  };

  Terminal.prototype.setScrollPosition = function() {
    var node, offset;
    node = ReactDOM.findDOMNode(this);
    offset = node.scrollHeight - node.offsetHeight;
    if (offset > 0) {
      return node.scrollTop = offset;
    }
  };

  Terminal.prototype.render = function() {
    var allowInput, cursorPosition, input, lines, prompt, ref;
    ref = this.props, input = ref.input, cursorPosition = ref.cursorPosition, lines = ref.lines, prompt = ref.prompt, allowInput = ref.allowInput;
    return React.createElement("div", {
      "className": "Terminal"
    }, lines.map(function(line, index) {
      return React.createElement(Line, React.__spread({
        "key": index
      }, line));
    }), (prompt ? React.createElement(Prompt, {
      "prompt": prompt,
      "input": input,
      "cursorPosition": cursorPosition
    }) : void 0));
  };

  return Terminal;

})(React.Component);

module.exports = Terminal;
