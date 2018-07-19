var request = require('request');
var url = 'https://github.com/kube-HPC/release-manager/releases/download/1.1.291/version.json';
var jsonObject;
request(url, function (error, response, body) {
  if (!error && response.statusCode == 200) {
     jsonObject = JSON.parse(body);
     console.log(jsonObject);
  }
});
