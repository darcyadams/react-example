React = require 'react/addons'
Request = require './utilities/server_request'
Facility = require './components/facility'

{div, input, ul} = React.DOM

Application = React.createClass
  
  displayName: 'Application'

  render: ->
    {searchTerm, results} = @state

    resultsElements = []
    resultsElements.push(Facility {
      key: facility.facilityId
      facility: facility
    }) for facility in results

    div {
      className: 'container'
    }, [
      div {
        key: 'search-bar'
        className: 'search-bar'
      }, [
        input {
          type: 'search'
          className: 'search-field'
          value: searchTerm
          onChange: @handleChange
        }
      ]
      ul {
        key: 'results'
        className: 'results'
      }, resultsElements
    ]

  getInitialState: ->
    {
      searchTerm: ''
      results: []
    }


  componentDidMount: ->
    @fetchResults('')

  
  handleChange: (e) ->
    term = e.target.value
    @setState
      searchTerm: term

    @fetchResults(term)




  fetchResults: (term) ->
    new Request
      url: '/facilities/search'
      data:
        q: term
      authenticate: no
    .done (results) =>
      @setState {results}


module.exports = Application

