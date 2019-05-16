import React, { Component } from "react";
import { Container, Row } from 'react-bootstrap'
import LootBox from '../contracts/LootBox.json';
import ETHIcon from "../static/images/ETH.svg"

class LootBoxOpen extends Component {

    state = {
      web3: this.props.web3,
      address: '0x497cf2da6fC6f449137689EABeD0B674108cC3db',
      contract: null,
      accounts: this.props.accounts,
      price: '0.025'
    };
  
    componentDidMount = async () => {
      try {
        let lootbox = await new this.state.web3.eth.Contract(LootBox, this.state.address);
        this.setState({ contract: lootbox});
        let contributers = await lootbox.methods.getContributers().call();
        console.log(contributers);
        //console.log('Price', price)
      } catch(error) {
        alert(`Error: could not mount LootBoxOpen component`);
      }
    };
  
    openBox = async () => {
      let wei = this.state.web3.utils.toWei(this.state.price, 'ether');
      let openBoxPromise = await this.state.contract.methods.openBox().send({
        from: this.state.accounts[0], value: wei});
      console.log(openBoxPromise);
      //return wei;
    }

    render() {
      return (
        <Container className = "container"> 
          <Row className = "priceLine">
            <h4>LootBox can be opened for {this.state.price} </h4>
            <img 
              alt="Logo" 
              style={{ width: 35, height: 40 }} 
              src={ETHIcon}
            />
          </Row>
          <button 
            style={{ margin: "10% auto", align: "center" }}
            className="" 
            onClick ={() => this.openBox()}
            >
              Open LootBox
          </button>
        </Container>
      );
    }
  }
  
  export default LootBoxOpen;
  