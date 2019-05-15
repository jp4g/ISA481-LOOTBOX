import React from 'react';
import './App.css';
import MetaMaskModal from './components/MetaMaskModal';
import TokenExplorer from './components/TokenExplorer';
import NavBar from './components/NavBar';

function App() {
  return (
    <div className="App">
      <row>
        <NavBar />
      </row>
      <TokenExplorer />
    </div>
  );
}

export default App;
