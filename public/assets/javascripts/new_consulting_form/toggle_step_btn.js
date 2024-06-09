document.getElementById('toggle-steps-show').addEventListener('click', e => {
    let icon = document.getElementById('toggle-steps-icon')
    icon.classList.toggle('toggled')

    let steps_column = document.getElementById('steps-show-column')
    steps_column.classList.toggle('d-none')
    window.scrollTo({ top: 0, behavior: 'instant' });
})