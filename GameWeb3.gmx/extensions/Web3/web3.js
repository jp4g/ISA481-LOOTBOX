function init()
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

function getBalance()
{

    /*Get Balance */
			web3.eth.getAccounts(function(error, accounts) {
				if(error) {
					console.log(error);
				}
				$('#Account').val(accounts[0]);
				web3.eth.getBalance(accounts[0]).then(function(result){
					console.log( "Balance : " ,web3.utils.fromWei(result, 'ether'));
					$('#Balance').val(web3.utils.fromWei(result, 'ether'));
				});
			});
			
			$('#checkBalance').click(function() {
			    var _account = $('#Account').val();
				web3.eth.getBalance(_account).then(function(result){
					console.log( "Balance : " ,web3.utils.fromWei(result, 'ether'));
					$('#Balance').val(web3.utils.fromWei(result, 'ether'));
				});
			});
    
}

