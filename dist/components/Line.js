// Generated by CoffeeScript 1.9.3
var Line;

Line = function(props) {
  var line;
  line = props.line;
  return React.createElement("div", {
    "className": "Line"
  }, React.createElement("span", {
    "className": "Line__prompt"
  }, line.prompt), React.createElement("span", {
    "className": "Line__input"
  }, line.input));
};

Line.displayName = "Line";

module.exports = Line;
