// var http = require('http');
var fs = require('fs');
var request = require('request');
request('https://github.com/kube-HPC/release-manager/releases/download/1.1.291/version.json', function (error, response, body) {
  if (!error && response.statusCode == 200) {
     var importedJSON = JSON.parse(body);
     var filename = "version.json"
     var newfilename = "versionew.json"
     importedJSON.versions.forEach(o=>console.log("project:", o.project,"tag:",o.tag));
     var data1 =  importedJSON.versions.forEach(o=>console.log("project:", o.project,"tag:",o.tag));
     var data = JSON.stringify(body);
     fs.writeFileSync(filename, data);
     fs.writeFileSync(newfilename, data1);
  }
})

// var filename = '/tmp/crap1';

// fs.readFile(filename, function(err, data) {
//     if(err) throw err;
//     theFile = data.toString().split("\n");
//     theFile.splice(-3,3);
//     fs.writeFile(filename, theFile.join("\n"), function(err) 

     //console.log(importedJSON.systemVersion);
     //console.log(importedJSON.versions[0].project);
     //importedJSON.versions.forEach(o=>console.log(o.tag));
     //console.log(importedJSON.versions.forEach(o=>console.log(o)));
     //console.log(importedJSON.versions);
     //console.log(importedJSON);


