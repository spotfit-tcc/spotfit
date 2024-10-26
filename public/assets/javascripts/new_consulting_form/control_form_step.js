let next_step = 1
let next_btn = document.getElementById("next-step")
let previous_btn = document.getElementById("previous-step")
let submit_btn = document.getElementById("submit-consulting")
let consulting_form = document.getElementById("consulting_form")

let step_icons = {
    "step-1-circle": "fas fa-info",
    "step-2-circle": "fas fa-images",
    "step-3-circle": "fas fa-dumbbell",
    "step-4-circle": "fas fa-users",
    "step-5-circle": "fas fa-dollar-sign"
}

function validate_form_step(){
    return true;
    let valid = true

    if(next_step > 1 && next_step <= 5){
        let form = document.querySelector(`#form-step-${next_step - 1}-container`)
        let required_inputs = form.querySelectorAll('[required]')
        
        for(const input of required_inputs){
            input.reportValidity()
            if(!input.reportValidity()){
                valid = false
            }
        }
    }

    return valid
}

function nextStep(){
    if(next_step > 5){
        return
    }

    if (!validate_form_step()) {
        return
    }

    if(next_step >= 2){
        previous_btn.classList.remove('d-none')
    }

    if(next_step === 5){
        next_btn.classList.add('d-none')
        submit_btn.classList.remove('d-none')
    }

    let previous_step_circle = document.getElementById(`step-${next_step - 1}-circle`)

    if(previous_step_circle){
        previous_step_circle.firstElementChild.className = 'fas fa-check'
        previous_step_circle.classList.add('concluded')
    }

    document.getElementById(`form-step-${next_step - 1}-container`)?.classList.add('d-none')

    document.getElementById(`form-step-${next_step}-container`)?.classList.remove('d-none')

    document.getElementById(`step-${next_step}-circle`)?.classList.remove('concluded')

    let current_step_circle = document.getElementById(`step-${next_step}-circle`)

    if(current_step_circle){
        current_step_circle.firstElementChild.className = step_icons[`step-${next_step}-circle`]
    }

    next_step++
}

function previousStep(){
    next_step--

    if(next_step <= 1){
        return
    }

    if(next_step === 2){
        previous_btn.classList.add('d-none')
    }

    if(next_step !== 6){
        submit_btn.classList.add('d-none')
        next_btn.classList.remove('d-none')
    }

    let previous_step_circle = document.getElementById(`step-${next_step - 1}-circle`)

    if(previous_step_circle){
        previous_step_circle.firstElementChild.className = step_icons[`step-${next_step - 1}-circle`]
        previous_step_circle.classList.remove('concluded')
    }

    document.getElementById(`form-step-${next_step - 1}-container`)?.classList.remove('d-none')

    document.getElementById(`form-step-${next_step}-container`)?.classList.add('d-none')
}

nextStep();

next_btn.addEventListener('click', nextStep)

previous_btn.addEventListener('click', previousStep)

consulting_form.addEventListener('submit', e => {
    e.preventDefault()

    let modal = new bootstrap.Modal(document.getElementById('consulting_form_confirm_modal'), {
        keyboard: false
    });

    modal.show();
})

document.getElementById("true_submit_form_btn").addEventListener('click', () => {
    consulting_form.submit()
})