getJSONData(url,callback);
//callback function 
fucntion callback(err, data) {
  if (err) {
    console.log('request failed');
    return;
  }
  // do something with data
}
