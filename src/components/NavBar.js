import React from "react"
//import { Link } from "react-router-dom"
//import * as ROUTES from "../../routes/names"
import ETHIcon from "../static/images/Ethereum.svg"

const Navbar = () => {
    return (
        <nav className="navbar sticky-top navbar-expand-sm navbar-dark bg-dark">
            <div className="container">
                <a className="navbar-brand">
                    <img alt="Logo" 
                        style={{ width: 110 }} 
                        src="http://g2qkq20j3w22tgg8w3w482sr-wpengine.netdna-ssl.com/wp-content/uploads/2018/01/unnamed.png" 
                    />
                    {' LootBox Prototype'}
                </a>
                <button
                    className="navbar-toggler"
                    type="button"
                    data-toggle="collapse"
                    data-target="#expanded"
                    aria-controls="expanded"
                    aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon" />
                </button>
            </div>
            <div className="col" >
                <img alt="Logo" 
                    style={{ width: 200 }} 
                    src={ETHIcon}
                    href='https://ethereum.org'
                />
            </div>
            <div className="float-left" >
                <img alt="Logo" 
                    style={{ width: 200 }} 
                    src="https://miamioh.edu/_files/images/ucm/policies/identity-standards/identity/informalsig3.png"
                    href='https://ethereum.org'
                />
            </div>
        </nav>
    )
}

export default Navbar
