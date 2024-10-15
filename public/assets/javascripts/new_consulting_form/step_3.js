let next_register_idx = 1
let next_professional_idx = 0

function build_professional(){
    const container = document.getElementById('professionals')

    container.insertAdjacentHTML(
        'beforeend',
        `<fieldset class="custom_fieldset new_professional mb-5" id="professional_${next_professional_idx}">
            <legend>Profissional ${next_professional_idx + 1}</legend>
            <i class="fas fa-trash delete_fieldset" onclick="remove_professional('${next_professional_idx}')"></i>

            <div class="consulting_professional">
                <h6>Informações do profissional</h6>

                <div class="mb-4">
                    <label for="professional_form_${next_professional_idx}_consulting_professional_name" class="form-label">Nome *</label>
                    <input type="text" class="form-control" id="professional_form_${next_professional_idx}_consulting_professional_name" name="professional_form[${next_professional_idx}][consulting_professional][name]">
                </div>

                <div class="mb-4">
                    <label for="professional_form_${next_professional_idx}_consulting_professional_instagram" class="form-label">Instagram</label>
                    <input type="text" class="form-control" id="professional_form_${next_professional_idx}_consulting_professional_instagram" name="professional_form[${next_professional_idx}][consulting_professional][instagram]">
                </div>

                <div class="mb-4">
                    <label for="professional_form_${next_professional_idx}_consulting_professional_phone" class="form-label">Telefone/celular</label>
                    <input type="text" class="form-control" id="professional_form_${next_professional_idx}_consulting_professional_phone" name="professional_form[${next_professional_idx}][consulting_professional][phone]">
                </div>

                <div class="mb-4">
                    <label for="professional_form_${next_professional_idx}_consulting_professional_email" class="form-label">Email de contato</label>
                    <input type="email" class="form-control" id="professional_form_${next_professional_idx}_consulting_professional_email" name="professional_form[${next_professional_idx}][consulting_professional][email]">
                </div>
            </div>

            <div class="professional_registers" id="professional_registers_${next_professional_idx}">
                <h6>Registros profissionais</h6>

                <div class="row mb-4 professional_register" id="professional_${next_professional_idx}_register_0">
                    <div class="col-md-3 mb-4 mb-md-0">
                        <label for="professional_form_${next_professional_idx}_professional_registers_0_profession" class="form-label">Profissão *</label>
                        <select class="form-select" id="professional_form_${next_professional_idx}_professional_registers_0_profession" name="professional_form[${next_professional_idx}][professional_registers][0][profession]">
                            <option value="0">Nutricionista</option>
                            <option value="1">Educador físico</option>
                            <option value="2">Fisioterapeuta</option>
                            <option value="3">Influenciador</option>
                        </select>
                    </div>

                    <div class="col-md-3 mb-4 mb-md-0">
                        <label for="professional_form_${next_professional_idx}_professional_registers_0_register_type" class="form-label">Tipo *</label>
                        <select class="form-select" id="professional_form_${next_professional_idx}_professional_registers_0_register_type" name="professional_form[${next_professional_idx}][professional_registers][0][register_type]">
                            <option value="0">CREF</option>
                            <option value="1">CFN</option>
                            <option value="2">CRN</option>
                        </select>
                    </div>

                    <div class="col-md-4 mb-4 mb-md-0">
                        <label for="professional_form_${next_professional_idx}_professional_registers_0_register" class="form-label">Nº do registro *</label>
                        <input type="text" class="form-control" id="professional_form_${next_professional_idx}_professional_registers_0_register" name="professional_form[${next_professional_idx}][professional_registers][0][register]">
                    </div>

                    <div class="col-md-1 mb-4 mb-md-0 remove-item-container">
                        <button type="button" class="btn btn-danger remove_register" onclick="remove_register('${next_professional_idx}', '0')"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-success" id="add_professional_${next_professional_idx}_register" onclick="add_professional_register('${next_professional_idx}')">
                <i class="fas fa-plus"></i> Adicionar Registro
            </button>
        </fieldset>`
    )

    next_professional_idx++
}

document.getElementById('add_professional').addEventListener('click', build_professional)

function add_professional_register(professional_idx) {
    const container = document.getElementById(`professional_registers_${professional_idx}`)
    
    container.insertAdjacentHTML(
        'beforeend',
        `<div class="row mb-4 professional_register" id="professional_${professional_idx}_register_${next_register_idx}">
            <div class="col-md-3 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_register_idx}_profession" class="form-label">Profissão *</label>
                <select class="form-select" id="professional_form_${professional_idx}_professional_registers_${next_register_idx}_profession" name="professional_form[${professional_idx}][professional_registers][${next_register_idx}][profession]">
                    <option value="0">Nutricionista</option>
                    <option value="1">Educador físico</option>
                    <option value="2">Fisioterapeuta</option>
                    <option value="3">Influenciador</option>
                </select>
            </div>

            <div class="col-md-3 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_register_idx}_register_type" class="form-label">Tipo *</label>
                <select class="form-select" id="professional_form_${professional_idx}_professional_registers_${next_register_idx}_register_type" name="professional_form[${professional_idx}][professional_registers][${next_register_idx}][register_type]">
                    <option value="0">CREF</option>
                    <option value="1">CFN</option>
                    <option value="2">CRN</option>
                </select>
            </div>

            <div class="col-md-4 mb-4 mb-md-0">
                <label for="professional_form_${professional_idx}_professional_registers_${next_register_idx}_register" class="form-label">Nº do registro *</label>
                <input type="text" class="form-control" id="professional_form_${professional_idx}_professional_registers_${next_register_idx}_register" name="professional_form[${professional_idx}][professional_registers][${next_register_idx}][register]">
            </div>

            <div class="col-md-1 mb-4 mb-md-0 remove-item-container">
                <button type="button" class="btn btn-danger remove_register" onclick="remove_register('${professional_idx}', '${next_register_idx}')"><i class="fas fa-trash"></i></button>
            </div>
        </div>`
    )

    next_register_idx++
}

function remove_professional(idx){
    document.getElementById(`professional_${idx}`).remove()
}

function remove_register(professional_idx, idx){
    document.getElementById(`professional_${professional_idx}_register_${idx}`).remove()
}

build_professional()