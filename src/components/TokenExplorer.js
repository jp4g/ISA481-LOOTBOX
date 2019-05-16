import React, { Component } from "react";
import SwordToken from "../contracts/SwordToken.json";
import { Container, Row } from 'react-bootstrap'
import getWeb3 from "../getWeb3";
import Sword from './Sword';
import LootBoxOpen from './LootBoxOpen';

//import "./App.css";

class TokenExplorer extends Component {
  state = {
    web3: null,
    contractAddress: '0xED829b4000C72c57f7b7b11DA9b5706bAD9C9ec0',
    lootboxAddress: '0x497cf2da6fC6f449137689EABeD0B674108cC3db',
    contractToken: null,
    accounts: null,
    tokens: null,
    supply: 0,
    balance: 0,
  };

  componentDidMount = async () => {
    try {
      const web3 = await getWeb3();
      const accounts = await web3.eth.getAccounts();
      const token = await new web3.eth.Contract(SwordToken, this.state.contractAddress);
      this.setState({ web3, accounts, contractToken: token });
      this.setState(this.totalSupply);
      this.setState(this.balanceOf(accounts[0]))
      this.setState(this.getAllTokens);
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

  getAllTokens = async () => {
    try {
      let idArray = this.idArray(this.state.totalSupply);
      let tokens = [];
      for(let i = 0; i < idArray.length; i++) {
        let res = this.state.contractToken.methods.tokenByIndex(i).call();
        tokens.push(res);
      }
      this.setState({ tokens });
    } catch (error) {
      alert(`Failed to  retrieve Token Storage Object`)
    }
  }

  idArray = async (size) => {
    let arr = [];
    for(let i = 0; i < size; i++)
      arr.push(i);
    return arr;
  }

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <Container className="TokenExplorer">
        
        <div id="top" className="row">
          <div className = "col-md-6 order-md-1">
            <h1>LootBox Interaction</h1>
            <LootBoxOpen 
              web3 = { this.state.web3 }
              accounts = { this.state.accounts }
            />           
          </div>
          <div className = "col-md-6 order-md-2">
            <h1>SwordToken Explorer</h1>
            <div>Supply of SwordToken: {this.state.supply}</div>
            <div>Injected Account: {this.state.accounts[0]} </div>
            <div>Injected Account's Balance: {this.state.balance}</div>
            <Row>
              <Sword
                web3 = {this.state.web3} 
                contractToken = {this.state.contractToken}
                id = {1}
              />
            </Row>
          </div>
        </div>
      </Container>
    );
  }
}

export default TokenExplorer;
