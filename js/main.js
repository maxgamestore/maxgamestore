function updateServerAddress() {
    fetch('../server-address.txt')
        .then(response => response.text())
        .then(data => {
            const addressElement = document.getElementById('server-address');
            if (addressElement) {
                addressElement.textContent = data.trim();
            }
        })
        .catch(() => {
            const addressElement = document.getElementById('server-address');
            if (addressElement) {
                addressElement.textContent = 'server.example.com:25565';
            }
        });
}

updateServerAddress();
setInterval(updateServerAddress, 30000);