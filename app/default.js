// Generated by CoffeeScript 1.9.1
var component, dom, hub, inject, ql, ref, svg, widget;

ref = require('odojs'), component = ref.component, dom = ref.dom, svg = ref.svg, widget = ref.widget;

inject = require('injectinto');

ql = require('odoql');

hub = require('odo-hub');

inject.bind('page:default', component({
  render: function(state, params) {
    console.log(state);
    return dom('div', {
      attributes: {
        "class": 'wrapper'
      }
    }, [
      svg('svg', {
        attributes: {
          "class": 'logo'
        }
      }, [
        svg('use', {
          'xlink:href': "/dist/odojs-examples-1.0.0.min.svg#odojs"
        })
      ]), dom('div', 'Hello')
    ]);
  }
}));
