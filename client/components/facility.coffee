React = require 'react/addons'
Request = require '../utilities/server_request'

{li, input} = React.DOM

Facility = React.createClass
  
  displayName: 'Facility'

  render: ->
    {facility} = @state

    li {
      className: 'search-result'
    }, [
      facility.facilityName
      input {
        type: 'checkbox'
        className: 'active-check'
        checked: facility.isActive
        onChange: @toggleActive
      }
    ]

  getInitialState: ->
    {
      facility: @props.facility
    }

  toggleActive: (e) ->
    {facility} = @state
    facility.isActive = not facility.isActive

    @setState {facility}
    
    id = facility.facilityId
    new Request
      method: 'PUT'
      url: "/facilities/#{id}"
      data: facility
      authenticate: no


module.exports = Facility