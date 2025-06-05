window.addEventListener('message', function (event) {
    const data = event.data;
    console.log("JS: NUI Message received:", event.data);
    if (data.type === "showUI") {
      document.getElementById("container").style.display = "block";
      console.log("JS: NUI Message received:", event.data);
      const positionsList = document.getElementById("positions");
       // Clear existing list

       positionsList.innerHTML = ''; // This clears all children safely


      data.positions.forEach(function(position) {
        const listItem = document.createElement("li");
        listItem.classList.add("position-item");
        const spanItem = document.createElement("span");
        const buttonItem = document.createElement("button");
        buttonItem.classList.add("delete-button");
        buttonItem.textContent = "🗑️";
        spanItem.textContent = `X: ${position.x.toFixed(4)}, Y: ${position.y.toFixed(4)}, Z: ${position.z.toFixed(4)}`;

        listItem.appendChild(spanItem);
        listItem.appendChild(buttonItem);
        positionsList.appendChild(listItem);
      });
    }
  
    if (data.type === "hideUI") {
      document.getElementById("container").style.display = "none";
    }
  });

  document.getElementById("closeBtn").addEventListener("click", function () {
    console.log("Close button clicked.");
    fetch(`https://${GetParentResourceName()}/closeUI`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({})
    });
  });

  document.getElementById("addPosition").addEventListener("click", function () {
    console.log("Add position button clicked.");
    fetch(`https://${GetParentResourceName()}/addSpot`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({})
    });
  });
  