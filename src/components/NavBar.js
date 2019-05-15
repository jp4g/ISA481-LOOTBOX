import React from "react"
//import { Link } from "react-router-dom"
//import * as ROUTES from "../../routes/names"

const Navbar = () => {
    return (
        <nav className="navbar sticky-top navbar-expand-sm navbar-dark bg-dark">
            <div className="container">
                <a className="navbar-brand" href="#">
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
                <div className="collapse navbar-collapse" id="expanded">
                    <ul className="navbar-nav mr-auto">
                        <li className="nav-item">
                            <a className="nav-link" href="#about">
                                Getting Started
                            </a>
                        </li>
                        <li className="nav-item-right">
                            <a className="nav-link" href="#services">
                                White Paper
                            </a>
                        </li>
                    </ul>
                    {/* <ul className="navbar-nav">
                        <li className="nav-item">
                            <Link className="nav-link" to={ROUTES.SIGNIN}>
                                Go to Console
                            </Link>
                        </li>
                        </ul> */}
                </div>
            </div>
        </nav>
    )
}

export default Navbar
