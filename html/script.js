const ecall = document.getElementById("ecall");

const vehicle = document.getElementById("vehicle");
const plate = document.getElementById("plate");
const time = document.getElementById("time");
const warningSound = new Audio("sounds/warning.ogg");
const successSound = new Audio("sounds/success.ogg");

warningSound.volume = 0.55;
successSound.volume = 0.45;

const status = document.querySelector(".status");

window.addEventListener("message", function(event){

    const data = event.data;

    switch(data.action){

        case "show":

            vehicle.innerHTML = data.vehicle || "Unbekannt";
            plate.innerHTML = data.plate || "-----";
            time.innerHTML = data.seconds;

            status.innerHTML = "Automatischer Notruf wird vorbereitet...";

            ecall.classList.remove("hidden");

        break;

        case "update":

            time.innerHTML = data.seconds;

        break;

        case "sent":

            status.innerHTML = "✓ Notruf erfolgreich gesendet.";

        break;

        case "cancel":

            status.innerHTML = "✕ Notruf wurde abgebrochen.";

            setTimeout(() => {

                ecall.classList.add("hidden");

            },1500);

        break;

        case "hide":

            ecall.classList.add("hidden");

        break;

    }

});