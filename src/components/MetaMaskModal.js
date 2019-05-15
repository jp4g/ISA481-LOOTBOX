import React, { Component } from "react";
import MetaMask from "../static/images/MetaMask.png";

class MetaMaskModal extends Component {
    static toggle() {
        MetaMaskModal.ref._toggle();
    }

    constructor(props) {
        super(props);
        MetaMaskModal.ref = this;
        this.state = {
            display: true,
            connected: false,
            address: ""
        }
    }

    _toggle = () => {
        this.setState(prev => ({ display: !prev.display }))
    }

    render() {
        return (
            <div
                style={{
                    display: this.state.display ? "flex" : "none",
                    position: "fixed",
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    transition: "all 0.5s ease",
                    alignItems: "center",
                    justifyContent: "center",
                    backgroundColor: "rgba(0, 0, 0, 0.5)"
                }}>
                <div
                    style={{
                        backgroundColor: "gray",
                        width: 300,
                        borderRadius: 10,
                        boxShadow:
                            "0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"
                    }}>
                    <div
                        style={{
                            position: "relative",
                            padding: 30,
                            display: "flex",
                            flexDirection: "column",
                            alignItems: "center",
                            justifyContent: "center"
                        }}>
                        <button
                            style={{
                                position: "absolute",
                                top: 5,
                                right: 10,
                                background: "none",
                                border: "none"
                            }}
                            onClick={this._toggle}>
                            <span style={{ fontSize: "1.5em" }}>x</span>
                        </button>
                        <p>Please install MetaMask</p>
                        <a
                            rel="noopener noreferrer"
                            href="https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=en"
                            target="_blank">
                            <img
                                className="img-fluid"
                                alt="MetaMask"
                                src={MetaMask}
                            />
                        </a>
                    </div>
                </div>
            </div>
        )
    }
}

export default MetaMaskModal
