// Generated by CoffeeScript 1.9.1

/*
  Register things to do when various events fire
 */
var hub, request, scene;

hub = require('odo-hub');

scene = require('./scene');

request = require('superagent');

hub.all(function(e, description, p, cb) {
  var timings;
  if (e === 'queries starting') {
    console.log("? " + p.description);
  } else if (e === 'queries completed') {
    timings = Object.keys(p).map(function(prop) {
      return "  " + prop + " in " + p[prop] + "ms";
    }).join('\n');
    console.log("√ completed\n" + timings);
  } else {
    console.log("+ " + description);
  }
  return cb();
});

hub.every('navigate to the default page', function(p, cb) {
  scene.update({
    page: {
      name: 'default'
    }
  });
  return cb();
});

hub.every('navigation error, {pathname} not found', function(p, cb) {
  scene.update({
    page: {
      name: 'error',
      message: "Sorry, the \"" + p.pathname + "\" page was not found."
    }
  });
  return cb();
});
