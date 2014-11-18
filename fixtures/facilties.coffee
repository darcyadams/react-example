express = require 'express'
_ = require 'lodash'
facilities = require('./data/facilities_data')
bodyParser = require 'body-parser'
jsonParser = bodyParser.json()


class FacilityService

  constructor: (app) ->
    @data = facilities
    app.get '/facilities', @get
    app.get '/facilities/search', @search
    app.get '/facilities/:id', @getById
    app.put '/facilities/:id', jsonParser, @put

  get: (req, res) => res.json @data


  getById: (req, res) => 
    {id} = req.params
    
    facility = _.findWhere @data,
      facilityId: id

    res.json facility

  
  search: (req, res) =>
    {q} = req.query

    rv = []
    rv.push facility for facility in @data when facility.facilityName.toLowerCase().search(q.toLowerCase()) isnt -1

    res.json rv


  put: (req, res) =>
    {id} = req.params
    payload = req.body

    for facility in @data
      if facility.facilityId is id
        _.assign(facility, payload)
        break

    res.json facility


module.exports = (app) ->
  facilityService = new FacilityService(app)
