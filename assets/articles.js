// const url = "https://hans-10364.medium.com/";
const url = 'https://medium.com/feed/@hans-10364';

fetch(url, {mode: "no-cors"})
  .then(function (response) {
	  if (response.ok) {
		  return response.text();
	  }
	  throw response;
  }).then(function (text) {
	  console.log(text);
  });