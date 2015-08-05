express = require 'express'
router = express.Router()
parser = require 'xml2json'
http = require 'http'
_ = require 'lodash'

KEY = 'Q2VM-JDUP-IMPQ-DT35'

router.get '/', (req, rsp, next) ->
  http.get("http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&key=#{KEY}&dir=s", (res) ->
    body = ''

    res.on 'data', (chunk) ->
      body += chunk

    res.on 'end', () ->
      data = JSON.parse(parser.toJson(body))
      data = data['root']
      data['station']['etd'] = _.reject data['station']['etd'], (etd) ->
        etd.abbreviation == 'FRMT'
      _.each data['station']['etd'], (etd) ->
        etd['estimate'] = _.map etd['estimate'], (estimate)->
          _.pick(estimate, ['minutes', 'length'])
      delete data.uri


      rsp.setHeader('content-type', 'application/json')
      rsp.send(JSON.stringify(data))
  ).on('error', (e) ->
    console.log("Got error: " + e.message)
  )


module.exports = router
