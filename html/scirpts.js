window.addEventListener("message", function(event){

    if(event.data.action == "show"){

        document.getElementById("ecall").classList.remove("hidden")

        document.getElementById("time").innerHTML = event.data.seconds

    }

    if(event.data.action == "update"){

        document.getElementById("time").innerHTML = event.data.seconds

    }

    if(event.data.action == "hide"){

        document.getElementById("ecall").classList.add("hidden")

    }

})