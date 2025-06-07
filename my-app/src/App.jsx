import { useState, useEffect } from 'react';
import './index.css';
import './App.scss';
function App() {
  const [positions, setPositions] = useState([]);
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const handleNuiMessage = (event) => {
      const data = event.data;
      console.log("JS: NUI Message received:", data);

      if (data.type === "showUI") {
        setPositions(data.positions || []);
        setVisible(true);
        document.getElementsByTagName("body")[0].style.display = "block";
      }

      if (data.type === "hideUI") {
        setVisible(false);
        document.getElementsByTagName("body")[0].style.display = "none";
      }
    };

    window.addEventListener('message', handleNuiMessage);
    return () => window.removeEventListener('message', handleNuiMessage);
  }, []);


  return (
    <>

      <button className="close-button !text-yellow-50" onClick={() =>
        fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' })
      }>
        Close
      </button>
    
      {/* <div id="container" className="container">
        <ul id="positions" className="positions-list">
          {positions.map((pos, index) => (
            <li key={index} className="position-item">
              <span>
                X: {pos.x.toFixed(4)}, Y: {pos.y.toFixed(4)}, Z: {pos.z.toFixed(4)}
              </span>
              <button className="delete-button" onClick={() => handleDelete(index)}>
                🗑️
              </button>
            </li>
          ))}
        </ul>
      </div> */}
    </>
  );
}

export default App;
