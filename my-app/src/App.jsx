import { useState, useEffect } from 'react';
import reactLogo from './assets/react.svg';
import viteLogo from '/vite.svg';
import './index.css';
// import './App.css';
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

  const handleDelete = (index) => {
    const updated = [...positions];
    updated.splice(index, 1);
    setPositions(updated);
    // Optional: send to backend here
  };

  return (
    <>
    <span
  class="inline-flex divide-x divide-gray-300 overflow-hidden rounded border border-gray-300 bg-white shadow-sm dark:divide-gray-600 dark:border-gray-600 dark:bg-gray-800"
>
  <button
    type="button"
    class="px-3 py-1.5 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 hover:text-gray-900 focus:relative dark:text-gray-200 dark:hover:bg-gray-700 dark:hover:text-white"
  >
    Edit
  </button>

  <button
    type="button"
    class="px-3 py-1.5 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 hover:text-gray-900 focus:relative dark:text-gray-200 dark:hover:bg-gray-700 dark:hover:text-white"
  >
    View
  </button>

  <button
    type="button"
    class="px-3 py-1.5 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 hover:text-gray-900 focus:relative dark:text-gray-200 dark:hover:bg-gray-700 dark:hover:text-white"
  >
    Delete
  </button>
</span>
      <button className="close-button !text-yellow-50" onClick={() =>
        fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' })
      }>
        Close
      </button>
    
      <div id="container" className="container">
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
      </div>
    </>
  );
}

export default App;
