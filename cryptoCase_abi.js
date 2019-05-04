var swordForgeABI = [
	{
		"constant": false,
		"inputs": [
			{
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "forgeSword",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_offset",
				"type": "uint256"
			}
		],
		"name": "randomOffset",
		"outputs": [
			{
				"name": "",
				"type": "uint8"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getSword",
		"outputs": [
			{
				"name": "grip",
				"type": "uint8"
			},
			{
				"name": "crossguard",
				"type": "uint8"
			},
			{
				"name": "blade",
				"type": "uint8"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getPowerLevel",
		"outputs": [
			{
				"name": "powerlevel",
				"type": "uint8"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_offset",
				"type": "uint256"
			}
		],
		"name": "getMaterial",
		"outputs": [
			{
				"name": "",
				"type": "uint8"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "handle",
				"type": "uint8"
			},
			{
				"indexed": false,
				"name": "crossguard",
				"type": "uint8"
			},
			{
				"indexed": false,
				"name": "blade",
				"type": "uint8"
			}
		],
		"name": "newSword",
		"type": "event"
	}
]