document.getElementById('add_professional_register').addEventListener('click', e => {
    const professional_idx = e.target.getAttribute('professional_idx')
    const container = document.getElementById(`professional_registers_${professional_idx}`)
    const next_idx = document.getElementsByClassName('professional_register').length
    
    container.innerHTML += `
        <div class="row mb-4 professional_register" id="professional_${professional_idx}_register_${next_idx}">
            <div class="col-md-3 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_idx}_profession" class="form-label">Profissão *</label>
                <select class="form-select" id="professional_form_${professional_idx}_professional_registers_${next_idx}_profession" name="professional_form[${professional_idx}][professional_registers][${next_idx}][profession]">
                    <option value="0">Nutricionista</option>
                    <option value="1">Educador físico</option>
                    <option value="2">Fisioterapeuta</option>
                    <option value="3">Influenciador</option>
                </select>
            </div>

            <div class="col-md-3 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_idx}_register_type" class="form-label">Tipo *</label>
                <select class="form-select" id="professional_form_${professional_idx}_professional_registers_${next_idx}_register_type" name="professional_form[${professional_idx}][professional_registers][${next_idx}][register_type]">
                    <option value="0">CREF</option>
                    <option value="1">CFN</option>
                    <option value="2">CRN</option>
                </select>
            </div>

            <div class="col-md-4 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_idx}_register" class="form-label">Nº do registro *</label>
                <input type="text" class="form-control" id="professional_form_${professional_idx}_professional_registers_${next_idx}_register" name="professional_form[${professional_idx}][professional_registers][${next_idx}][register]">
            </div>

            <div class="col-md-1 mb-4 mb-md-0 remove-item-container">
                <button type="button" class="btn btn-danger remove_register" onclick="remove_register('${professional_idx}', '${next_idx}')"><i class="fas fa-trash"></i></button>
            </div>
        </div>
    `
})

function remove_register(professional_idx, idx){
    document.getElementById(`professional_${professional_idx}_register_${idx}`).remove()
}