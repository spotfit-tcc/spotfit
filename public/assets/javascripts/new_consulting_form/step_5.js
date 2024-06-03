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

let next_plan_idx = 1

document.getElementById('add_plan').addEventListener('click', () => {
    const container = document.getElementById('plans')

    container.insertAdjacentHTML(
        'beforeend',
        `<fieldset class="custom_fieldset new_plan mb-5" id="plan_${next_plan_idx}">
            <legend>Plano ${next_plan_idx + 1}</legend>
            <i class="fas fa-trash delete_fieldset" onclick="remove_plan('${next_plan_idx}')"></i>

            <div class="plan">
                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_plan" class="form-label">Nome do plano *</label>
                    <input type="text" class="form-control" id="plans_${next_plan_idx}_plan" name="plans[${next_plan_idx}][plan]">
                </div>

                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_price" class="form-label">Preço *</label>
                    <div class="input-group">
                        <span class="input-group-text">R$</span>
                        <input type="text" class="form-control price-input" id="plans_${next_plan_idx}_price" name="plans[${next_plan_idx}][price]"></input>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="plans_${next_plan_idx}_period" class="form-label">Duração (meses) *</label>
                    <div class="input-group">
                        <input type="number" class="form-control" id="plans_${next_plan_idx}_period" name="plans[${next_plan_idx}][period]">
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

                <div class="plan_benefits">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="plans_${next_plan_idx}_benefits_1" name="plans[${next_plan_idx}][benefits][]" value="1">
                        <label class="form-check-label" for="plans_${next_plan_idx}_benefits_1">Treino periodizado</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="plans_${next_plan_idx}_benefits_2" name="plans[${next_plan_idx}][benefits][]" value="2">
                        <label class="form-check-label" for="plans_${next_plan_idx}_benefits_2">Dieta</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="plans_${next_plan_idx}_benefits_3" name="plans[${next_plan_idx}][benefits][]" value="3">
                        <label class="form-check-label" for="plans_${next_plan_idx}_benefits_3">Prescrição de alongamentos</label>
                    </div>
                </div>
            </div>
        </fieldset>`
    )

    let cleave = new Cleave(`#plans_${next_plan_idx}_price`, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
        numeralDecimalScale: 2,
        numeralIntegerScale: 5,  // Ajuste conforme necessário para permitir números grandes
        rawValueTrimPrefix: true
    });

    next_plan_idx++
})

function remove_plan(idx){
    document.getElementById(`plan_${idx}`).remove()
}
