var http = require('http');
var request = require('request');
request('https://github.com/kube-HPC/release-manager/releases/download/1.1.291/version.json', function (error, response, body) {
  if (!error && response.statusCode == 200) {
     var importedJSON = JSON.parse(body);
     console.log(importedJSON.systemVersion);
     console.log(importedJSON.versions[0].project);
     console.log(importedJSON.versions);
     //console.log(importedJSON);
  }
})
