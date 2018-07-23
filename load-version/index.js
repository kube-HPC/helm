// var http = require('http');
var fs = require('fs');
var request = require('request');
yaml = require('js-yaml');
request('https://github.com/kube-HPC/release-manager/releases/download/1.1.292/version.json', function (error, response, body) {
  if (!error && response.statusCode == 200) {
     var importedJSON = JSON.parse(body);
     var filename = "version.json"
     const project = importedJSON.versions.forEach(o=>console.log("project:", o.project));
     importedJSON.versions.forEach(o=>console.log("project:", o.project,"tag:",o.tag));
     var data = JSON.stringify(body.replace(/\r?\n|\r/g, " "));
     fs.writeFileSync(filename, data.trim());
     var importedYAML = yaml.safeLoad(fs.readFileSync('/home/eli/Dropbox/hkube/helm/hkube/values.yaml', 'utf8'));
     console.log(importedYAML);
     let yamlClone = { ...importedYAML};
     console.log(yamlClone);
     const indentedJson = JSON.stringify(importedYAML, null,4);
     console.log(indentedJson);
  }
})

     //let jsonClone = { ...importedJSON };
     //console.log(jsonClone);
//console.log(data.replace(/\r?\n|\r/g, " "));
//let yamlClone = { ...importedYAML };
//let overidyamlClone = { ...myyaml.importedYAML.replace(/\r?valuetag/g, "newvaluetag") };
//var data1 =  importedJSON.versions.forEach(o=>console.log("project:", o.project,"tag:",o.tag));

// function findAndReplace(object, value, replacevalue) {
//   for (var x in object) {
//     if (object.hasOwnProperty(x)) {
//       if (typeof object[x] == 'object') {
//         findAndReplace(object[x], value, replacevalue);
//       }
//       if (object[x] == value) { 
//         object["name"] = replacevalue;
//         // break; // uncomment to stop after first replacement
//       }
//     }
//   }
// }



