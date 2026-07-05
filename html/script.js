const ecall = document.getElementById("ecall");

const vehicle = document.getElementById("vehicle");
const plate = document.getElementById("plate");
const time = document.getElementById("time");
const status = document.querySelector(".status");

const circle = document.getElementById("progressCircle");

const radius = 62;
const circumference = 2 * Math.PI * radius;

circle.style.strokeDasharray = circumference;
circle.style.strokeDashoffset = 0;

const warningSound = new Audio("sounds/warning.ogg");
const successSound = new Audio("sounds/success.ogg");

warningSound.volume = 0.55;
successSound.volume = 0.45;

function updateCircle(seconds) {

    const max = 10;
    const percent = seconds / max;

    circle.style.strokeDashoffset =
        circumference - (circumference * percent);

}

window.addEventListener("message", function(event){

    const data = event.data;

    switch(data.action){

        case "show":

            vehicle.innerHTML = data.vehicle || "Unbekannt";
            plate.innerHTML = data.plate || "-----";

            time.innerHTML = data.seconds;

            updateCircle(data.seconds);

            status.innerHTML = "Automatischer Notruf wird vorbereitet...";

            warningSound.currentTime = 0;
            warningSound.play().catch(() => {});

            ecall.classList.remove("hidden");

        break;

        case "update":

            time.innerHTML = data.seconds;

            updateCircle(data.seconds);

            warningSound.currentTime = 0;
            warningSound.play().catch(() => {});

        break;

        case "sent":

            status.innerHTML = "✓ Notruf erfolgreich gesendet.";

            successSound.currentTime = 0;
            successSound.play().catch(() => {});

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