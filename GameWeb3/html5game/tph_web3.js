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

function getBalance(account)
{
    var ethId;
    var returnBalance;

    if(account == 1)
    {
        ethId = "0xeD5a6cf86b5aB215dBf11896Ac3DEf618aaF4bAC";
    }
    else
    {
        ethId = "0x998b445cA5057E8738aD107951D882c054Cf68ED";
    }
	if(web3.eth.getBalance(ethId) != undefined)
	{
	web3.eth.getBalance(ethId)
	.then(function (balance)
	{
		console.log(balance);
		return balance;
	});
	}
			
}
