
document.getElementById('toggle-theme').addEventListener('click', function () {
    document.body.classList.toggle('dark-mode');
    if (document.body.classList.contains('dark-mode')) {
        document.body.style.backgroundColor = '#121212';
        document.body.style.color = '#f9f9f9';
    } else {
        document.body.style.backgroundColor = '#f9f9f9';
        document.body.style.color = '#333';
    }
});
