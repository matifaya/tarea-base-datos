document.addEventListener('DOMContentLoaded', () => {
  const loadPlayersButton = document.getElementById('loadPlayers');
  const playersList = document.getElementById('playersList');
  const playerModal = document.getElementById('playerModal');
  const modalBody = document.getElementById('modalBody');
  const closeModal = document.querySelector('.close');

  loadPlayersButton.addEventListener('click', () => {
    playersList.innerHTML = ''; // Limpiar lista antes de cargar nuevos jugadores

    fetch('https://bymykel.github.io/CSGO-API/player/stats/123456')
      .then(response => response.json())
      .then(data => {
        const playerCard = document.createElement('div');
        playerCard.classList.add('card');
        playerCard.innerHTML = `
          <h3>${data.username}</h3>
          <p><strong>Rango:</strong> ${data.rank}</p>
          <button class="viewMore" data-id="${data.player_id}">Ver más</button>
        `;
        playersList.appendChild(playerCard);

        const viewMoreButton = playerCard.querySelector('.viewMore');
        viewMoreButton.addEventListener('click', () => {
          fetch(`https://bymykel.github.io/CSGO-API/player/stats/${data.player_id}`)
            .then(response => response.json())
            .then(playerData => {
              modalBody.innerHTML = `
                <h2>${playerData.username}</h2>
                <p><strong>Rango:</strong> ${playerData.rank}</p>
                <p><strong>Kills:</strong> ${playerData.kills}</p>
                <p><strong>Deaths:</strong> ${playerData.deaths}</p>
                <p><strong>Headshots:</strong> ${playerData.headshots}</p>
                <p><strong>Accuracy:</strong> ${playerData.accuracy}</p>
              `;
              playerModal.style.display = 'block';
            });
        });
      })
      .catch(error => {
        console.error('Error al cargar los jugadores:', error);
        alert('Hubo un problema al cargar los jugadores.');
      });
  });

  closeModal.addEventListener('click', () => {
    playerModal.style.display = 'none';
  });

  window.addEventListener('click', (event) => {
    if (event.target === playerModal) {
      playerModal.style.display = 'none';
    }
  });
});
