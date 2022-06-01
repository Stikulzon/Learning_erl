var arr = [1,2,3,4,5];
var n = arr.length;
for(i = 0; i < n; i++){
  for(j = 0; j < n; j++){
    if(j == i){continue;}
    for(k = 0; k < n; k++){
      if((k == j) || (k == i)){continue;}
      console.log( arr[i] + '' + arr[j] + '' + arr[k] + '' );
    }
  }
}