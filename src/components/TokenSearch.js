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
  
    {/* componentDidMount = async () => {
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
    }; */}
  
    render() {
      return (
        <div classname="TokenExplorer">
            <row>
                <p> test </p>
            </row>
            <row>
                <SearchBar />
            </row>
        </div>
      );
    }
  }
  
  export default TokenSearch;
  