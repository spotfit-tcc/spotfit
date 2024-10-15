document.querySelectorAll('.price-input').forEach(input => {
    let cleave = new Cleave(input, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
        numeralDecimalScale: 2,
        numeralIntegerScale: 5,  // Ajuste conforme necessário para permitir números grandes
        rawValueTrimPrefix: true
    });
})

let next_plan_idx = 0

function build_plan(){
    const container = document.getElementById('plans')

    container.insertAdjacentHTML(
        'beforeend',
        `<fieldset class="custom_fieldset new_plan mb-5" id="plan_${next_plan_idx}">
            <legend>Plano ${next_plan_idx + 1}</legend>
            <i class="fas fa-trash delete_fieldset" onclick="remove_plan('${next_plan_idx}')"></i>

            <div class="plan">
                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_plan" class="form-label">Nome do plano *</label>
                    <input type="text" class="form-control" required id="plans_${next_plan_idx}_plan" name="plans[${next_plan_idx}][plan]">
                </div>

                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_price" class="form-label">Preço *</label>
                    <div class="input-group">
                        <span class="input-group-text">R$</span>
                        <input type="text" class="form-control price-input" required id="plans_${next_plan_idx}_price" name="plans[${next_plan_idx}][price]"></input>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_period" class="form-label">Duração *</label>
                    <div class="input-group">
                        <input type="number" class="form-control" required id="plans_${next_plan_idx}_period" name="plans[${next_plan_idx}][period]">
                        <span class="input-group-text">meses</span>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_desc" class="form-label">Descrição</label>
                    <textarea class="form-control" id="plans_${next_plan_idx}_desc" name="plans[${next_plan_idx}][desc]"></textarea>
                </div>
            </div>

            
            <div>
                <h6>Escolha os benefícios incluídos nesse plano</h6>

                <div class="plan_benefits" id="plan_${next_plan_idx}_benefits" data-plan-idx="${next_plan_idx}">
                </div>
            </div>
        </fieldset>`
    )

    build_benefits_options(next_plan_idx)

    let cleave = new Cleave(`#plans_${next_plan_idx}_price`, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
        numeralDecimalScale: 2,
        numeralIntegerScale: 5,  // Ajuste conforme necessário para permitir números grandes
        rawValueTrimPrefix: true
    });

    next_plan_idx++
}

document.getElementById('add_plan').addEventListener('click', build_plan)

build_plan()

function remove_plan(idx){
    document.getElementById(`plan_${idx}`).remove()
}

function build_benefits_options(plan_idx){
    let container = document.getElementById(`plan_${plan_idx}_benefits`)
    let benefit_options = document.getElementsByClassName("benefit_option")

    container.innerHTML = ""

    for(i = 0; i < benefit_options.length; i++){
        container.insertAdjacentHTML(
            'beforeend',
            `<div class="form-check">
                <input class="form-check-input" type="checkbox" id="plans_${plan_idx}_benefits_${benefit_options[i].getAttribute('data-benefit-idx')}" name="plans[${plan_idx}][benefits][]" value="${benefit_options[i].getAttribute('data-benefit-idx')}">
                <label class="form-check-label" for="plans_${plan_idx}_benefits_${benefit_options[i].getAttribute('data-benefit-idx')}">${benefit_options[i].value}</label>
            </div>`
        )
    }
}
