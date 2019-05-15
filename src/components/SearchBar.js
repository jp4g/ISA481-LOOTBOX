import React, { Component } from "react"

class SearchBar extends Component {
    render() {
        return (
            <div className="input-group" display="inline" style={{ width: 300 }} >
                <input
                    type="search"
                    className="form-control"
                    placeholder="Search for a token by ID"
                />
                <button className="">Search</button>
            </div>
        )
    }
}

export default SearchBar
