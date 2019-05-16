import React, { Component } from "react"

class SearchBar extends Component {

    idQuery = (e) => {
        console.log(document.getElementById("input"));
    }
    
    render() {
        return (
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
                    onClick ={() => console.log(document.getElementById("input").value)}>Search
                </button>
            </div>
        )
    }
}

export default SearchBar
