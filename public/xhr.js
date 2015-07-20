/**
 * Created by samuelstephen on 7/15/15.
 */
var request = new XMLHttpRequest();
request.open('GET', '/api/assignments', true);

request.onreadystatechange = function() {
    if (this.readyState === 4) {
        if (this.status >= 200 && this.status < 400) {
            // Success!
            var data = JSON.parse(this.responseText);
        } else {
            // Error :(
        }
    }
};

request.send();
request = null;