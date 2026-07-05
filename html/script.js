const ecall = document.getElementById("ecall");

const vehicle = document.getElementById("vehicle");
const plate = document.getElementById("plate");
const time = document.getElementById("time");
const status = document.getElementById("status");

const progressCircle = document.getElementById("progressCircle");

const radius = 70;
const circumference = 2 * Math.PI * radius;

progressCircle.style.strokeDasharray = circumference;
progressCircle.style.strokeDashoffset = 0;

let maxSeconds = 10;

function updateCircle(seconds){

    const percent = seconds / maxSeconds;

    progressCircle.style.strokeDashoffset =
        circumference - (circumference * percent);

}

window.addEventListener("message", function(event){

    const data = event.data;

    switch(data.action){

        case "show":

            maxSeconds = data.seconds;

            vehicle.innerHTML = data.vehicle || "Unbekannt";
            plate.innerHTML = data.plate || "-----";
            time.innerHTML = data.seconds;

            status.innerHTML = "Automatischer Notruf wird vorbereitet...";

            updateCircle(data.seconds);

            ecall.classList.remove("hidden");

        break;

        case "update":

            time.innerHTML = data.seconds;

            updateCircle(data.seconds);

        break;

        case "sent":

            status.innerHTML = "✔ Notruf erfolgreich gesendet.";

            setTimeout(function(){

                ecall.classList.add("hidden");

            },3000);

        break;

        case "cancel":

            status.innerHTML = "✖ Automatischer Notruf wurde abgebrochen.";

            setTimeout(function(){

                ecall.classList.add("hidden");

            },1500);

        break;

        case "hide":

            ecall.classList.add("hidden");

        break;

    }

});