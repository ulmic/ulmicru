global.__RWR_ENV__ = {};
require('babel-core/register');
const IM = require('react-webpack-rails').integrationsManager;
require('./index');

const http = require('http');
const dispatcher = require('httpdispatcher');
const PORT = 8081;

function handleRequest(request, response){
  try {
    console.log(`started: ${request.method} "${request.url}" at ${new Date().toLocaleTimeString()}`);
    dispatcher.dispatch(request, response);
  } catch(ex) {
    console.log(ex)
    response.writeHead(500);
    response.end(ex.name + ': ' + ex.message);
  }
}

dispatcher.onPost("/run", function(request, response) {
  try {
    const data = JSON.parse(request.body);
    const result = IM.runNodeIntegration(data);
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.end(result);
  } catch(ex) {
    console.log(ex)
    response.writeHead(500);
    response.end("nodeRun failed:\n" + ex.name + ': ' + ex.message);
  }
});

const server = http.createServer(handleRequest);

server.listen(PORT, function(){
  console.log("Server listening on: http://localhost:%s", PORT);
});
