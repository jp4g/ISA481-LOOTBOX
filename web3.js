function init(i)
{
if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
        // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
}
web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
/* Get Node Info */
web3.eth.getNodeInfo(function(error, result){
    if(error){
        console.log( "error" ,error);
    }
    else{
        console.log( "result",result );
        $('#NodeInfo').val(result);
    }
});
}

function getBalance(account)
{
    const ethId;

    if(account ==1)
    {
        ethId = "0xeD5a6cf86b5aB215dBf11896Ac3DEf618aaF4bAC";
    }
    else
    {
        ethId = "0x998b445cA5057E8738aD107951D882c054Cf68ED";
    }

    /*Get Balance */
			web3.eth.getAccounts(function(error, accounts) {
				if(error) {
					console.log(error);
				}
				$('#Account').val(ethId);
				web3.eth.getBalance(ethId).then(function(result){

					$('#Balance').val(web3.utils.fromWei(result, 'ether'));
				});
			});
			
			$('#checkBalance').click(function() {
			    var _account = ethId;
				web3.eth.getBalance(_account).then(function(result){

					$('#Balance').val(web3.utils.fromWei(result, 'ether'));
				});
			});
    
}

