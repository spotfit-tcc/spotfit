let next_benefit_idx = 1

document.getElementById('add_benefit').addEventListener('click', () => {
    const container = document.getElementById('benefits')

    container.insertAdjacentHTML(
        'beforeend',
        `<fieldset class="custom_fieldset new_benefit mb-5" id="benefit_${next_benefit_idx}">
            <legend>Benefício ${next_benefit_idx + 1}</legend>
            <i class="fas fa-trash delete_fieldset" onclick="remove_benefit('${next_benefit_idx}')"></i>

            <div class="benefit">
                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_benefit" class="form-label">Nome do benefício *</label>
                    <input type="text" class="form-control" id="benefits_${next_benefit_idx}_benefit" name="benefits[${next_benefit_idx}][benefit]">
                </div>

                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_desc" class="form-label">Descrição</label>
                    <textarea class="form-control" id="benefits_${next_benefit_idx}_desc" name="benefits[${next_benefit_idx}][desc]"></textarea>
                </div>

                <div class="mb-4">
                    <label for="benefits_${next_benefit_idx}_icon" class="form-label">Ícone</label>
                    <input type="file" class="form-control" id="benefits_${next_benefit_idx}_icon" name="benefits[${next_benefit_idx}][icon]">
                </div>
            </div>
        </fieldset>`
    )

    next_benefit_idx++
})

function remove_benefit(idx){
    document.getElementById(`benefit_${idx}`).remove()
}