//js para formulário de nova consultoria. Se precisar, mover esse código para um arquivo separado
const previewContainer = document.getElementById('images_preview');

document.getElementById('consulting_images').addEventListener('change', (e) => {
    const files = Array.from(e.target.files)
    if(files.length == 0){
        alert("Nenhuma imagem selecionada")
        e.target.value = null
        return
    }

    let not_image_files = files.filter((file) => {
        return file.type != "image/png" && file.type != "image/jpeg"
    })

    if(not_image_files.length > 0){
        alert("Arquivo inválido selecionado")
        e.target.value = null
        return
    }

    if(files.length > 5){
        alert("Mais de 5 imagens selecionadas")
        e.target.value = null
        return
    }

    previewContainer.innerHTML = ''

    files.forEach(file => {
        const reader = new FileReader();

        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            previewContainer.appendChild(img);
        }

        reader.readAsDataURL(file);
    })
})

document.getElementById('clean_images_btn').addEventListener('click', () => {
    document.getElementById("consulting_images").value = null
    previewContainer.innerHTML = ''
})