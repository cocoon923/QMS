/**
 * Created by chenmm on 9/3/2014.
 */

function prompt() {

    function basic(message) {
        $.prompt(message);
    }

    function queryDelete() {
        $.prompt("Open your javascript console to see the answer.", {
            title: "Are you Ready?",
            buttons: { "Yes, I'm Ready": true, "No, Lets Wait": false },
            submit: function(e,v,m,f){
                // use e.preventDefault() to prevent closing when needed or return false.
                // e.preventDefault();

                console.log("Value clicked was: "+ v);
            }
        });
    }

    return {"basic": basic, "queryDelete": queryDelete};
}