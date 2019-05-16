import React, { Component } from "react";

class Sword extends Component {
    state = {
      web3: this.props.web3,
      contractToken: this.props.contractToken,
      tokenID: this.props.id,
      token: {
        grip: null,
        crossguard: null,
        crossguardblade: null
      }
    };
  
    componentDidMount = async () => {
      try {
        await this.getSword(this.state.tokenID);
      } catch (error) {
        alert(`Failed to load web3, accounts, or contract. Check console for details.`);
        console.error(error);
      }
    };
  
    getSword = async (id) => {
      try {
        const { contractToken, web3 } = this.state;
        const swordObj = await contractToken.methods.getSword(id).call();     
        const sword = {
          grip: web3.utils.hexToNumber(swordObj.grip._hex),
          crossguard: web3.utils.hexToNumber(swordObj.crossguard._hex),
          blade: web3.utils.hexToNumber(swordObj.blade._hex)
        }
        this.setState({token: sword});
      } catch (error) {
        alert(`Failed to get sword of tokenID ${id}`)
      }
    }

    getPowerLevel = () =>  {
        let sword = this.state.token;
        return sword.grip + sword.crossguard + sword.blade;
    }
  
    render() {
      return (
        <section className = "sword">
            <div 
                className="input-group" 
                display="inline" 
                style={{ width: 300 }} 
                ref
            >
                <input
                    type="search"
                    className="form-control"
                    id = "input"
                    placeholder="Search for a token by ID"
                />
                <button 
                    className="" 
                    onClick = {() => 
                        this.setState({ tokenID: document.getElementById("input").value }, 
                        this.setState(this.getSword(this.state.tokenID))
                    )}
                >
                Search
                </button>
            </div>
            <div className="card" style={{width: "18rem"}}>
                <div className="card-body">
                    <h5 className="card-title">Sword Token (ID {this.state.tokenID})</h5>
                    <div className="card-text">
                        <p> Power level: {this.getPowerLevel()} </p>
                        <p> Grip: {this.state.token.grip} </p>
                        <p> Crossguard: {this.state.token.crossguard} </p>
                        <p> Blade: {this.state.token.blade} </p>
                    </div>
                </div>
            </div>
        </section>
      );
    }
  }
  
  export default Sword;
  