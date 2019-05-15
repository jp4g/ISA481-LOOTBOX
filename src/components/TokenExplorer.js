import React, { Component } from "react";
import SwordToken from "../contracts/SwordToken.json";
import getWeb3 from "../getWeb3";
import SearchBar from './SearchBar';

//import "./App.css";

class TokenExplorer extends Component {
  state = {
    web3: null,
    contractAddress: '0xED829b4000C72c57f7b7b11DA9b5706bAD9C9ec0',
    network: 'kovan',
    contractToken: null,
    supply: 0,
    balance: 0,
    tokens: []
  };

  componentDidMount = async () => {
    try {
      const web3 = await getWeb3();
      const accounts = await web3.eth.getAccounts();
      const token = new web3.eth.Contract(SwordToken, this.state.contractAddress);
      this.setState({ web3, accounts, contractToken: token });
      this.setState(this.totalSupply);
      this.setState(this.balanceOf(accounts[0]))
      this.setState(this.ownedTokens(accounts[0]));
      
    } catch (error) {
      alert(`Failed to load web3, accounts, or contract. Check console for details.`);
      console.error(error);
    }
  };

  totalSupply = async () => {
    try {
      const { contractToken, web3 } = this.state;
      const supplyPromise = await contractToken.methods.totalSupply().call();
      const supply = await web3.utils.hexToNumber(supplyPromise._hex);
      this.setState({ supply });
    } catch (error) {
      alert(`Failed to get total SwordToken supply!`);
      console.log(error);
    }
  }

  balanceOf = async (address) => {
    try {
      const { contractToken, web3 } = this.state;
      const balancePromise = await contractToken.methods.balanceOf(address).call();
      const balance = await web3.utils.hexToNumber(balancePromise._hex);
      this.setState({ balance });
    } catch (error) {
      alert(`Failed to get balanceOf ${address}!`);
      console.log(error);
    }
  }

  ownedTokens = async (address) => {
    
    try {
      const { contractToken, web3 } = this.state;
      await this.setState(this.balanceOf(address));
      console.log(this.state.balance);
      for(var i = 0; i < this.state.balance; i++) {
        const ownedPromise = await contractToken.methods.tokenByIndex(address, i).call();
        console.log(this.state);
        console.log(ownedPromise);
      }
    } catch (error) {
      alert(`Failed to get ownedTokens of ${address}`)
    }
  }

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      
      <section className="TokenExplorer">
        
        <div id="top"
          className="row"
          style={{
              height: "95vh",
              alignItems: "center"
          }}>
          <div className = "col-md-6 order-md-1">
            <h1>Sword Token Explorer</h1>
            <p>
              !! DEVELOPMENT ENVIRONMENT !!
            </p>
            <div>The total supply is: {this.state.supply}</div>
            <div>The connected account is: {this.state.accounts[0]} </div>
            <div>The connected account has a balance of: {this.state.balance}</div>
          </div>
          <div className = "col-md-6 order-md-2">
            <row>
              <SearchBar />
            </row>
          </div>
        </div>
      </section>
    );
  }
}

export default TokenExplorer;
