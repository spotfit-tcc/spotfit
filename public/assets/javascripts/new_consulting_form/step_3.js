let next_benefit_idx = 0
let benefit_options_el = document.getElementsByClassName('benefit_option')
if(benefit_options_el.length > 0){
    next_benefit_idx = benefit_options_el.length + 1
}

function build_benefit(){
    const container = document.getElementById('benefits')

    container.insertAdjacentHTML(
        'beforeend',
        `<fieldset class="custom_fieldset new_benefit mb-5" id="benefit_${next_benefit_idx}">
            <legend>Benefício ${next_benefit_idx + 1}</legend>
            <i class="fas fa-trash delete_fieldset" onclick="remove_benefit('${next_benefit_idx}')"></i>

            <div class="benefit">
                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_benefit" class="form-label">Nome do benefício *</label>
                    <input type="text" class="form-control benefit_option" required id="benefits_${next_benefit_idx}_benefit" name="benefits[${next_benefit_idx}][benefit]" data-benefit-idx="${next_benefit_idx}" onchange="reload_plan_benefits()">
                </div>

                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_description" class="form-label">Descrição</label>
                    <textarea class="form-control" id="benefits_${next_benefit_idx}_description" name="benefits[${next_benefit_idx}][description]"></textarea>
                </div>

                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_icon" class="form-label">Ícone</label>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text" id="benefits_${next_benefit_idx}_icon_show"></i></span>
                        <select class="form-select icon_form" id="benefits_${next_benefit_idx}_icon" name="benefits[${next_benefit_idx}][icon]" onchange="show_benefit_select_icon(${next_benefit_idx}, this)">
                            <option value=""></option>
                            <option value="fa-solid fa-weight-scale">Balança</option>
                            <option value="fa-solid fa-heart">Coração</option>
                            <option value="fa-solid fa-person-walking">Corrida</option>
                            <option value="fa-solid fa-user-nurse">Enfermeira</option>
                            <option value="fa-solid fa-dumbbell">Halter</option>
                            <option value="fa-solid fa-receipt">Receita</option>
                            <option value="fa-solid fa-syringe">Siringa</option>
                            <option value="fa-solid fa-utensils">Talheres</option>
                        </select>
                    </div>
                </div>
            </div>
        </fieldset>`
    )

    next_benefit_idx++
    reload_plan_benefits()
}

document.getElementById('add_benefit').addEventListener('click', build_benefit)

if(benefit_options_el.length === 0){
    build_benefit();
}

function remove_benefit(idx){
    document.getElementById(`benefit_${idx}`).remove()
    reload_plan_benefits()
}

function reload_plan_benefits(){
    let plan_benefits = document.getElementsByClassName('plan_benefits')
    let professional_benefits = document.getElementsByClassName('professional_benefits')

    for(let i = 0; i < plan_benefits.length; i++){
        plan_benefits[i].innerHTML = ''
        build_benefits_options(plan_benefits[i].getAttribute('data-plan-idx'))
    }

    for(let i = 0; i < professional_benefits.length; i++){
        professional_benefits[i].innerHTML = ''
        build_professional_benefits_options(professional_benefits[i].getAttribute('data-professional-idx'))
    }
}

function show_benefit_select_icon(benefit_idx, el){
    let span = document.getElementById(`benefits_${benefit_idx}_icon_show`)
    let icon = el.value
    span.innerHTML = `<i class="${icon}"></i>`
}