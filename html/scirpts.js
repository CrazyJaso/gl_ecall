const box = document.getElementById("ecall")
const time = document.getElementById("time")

window.addEventListener("message",(event)=>{

    switch(event.data.action){

        case "show":
            box.style.display="block"
            time.innerHTML=event.data.seconds
        break

        case "update":
            time.innerHTML=event.data.seconds
        break

        case "hide":
            box.style.display="none"
        break

    }

})