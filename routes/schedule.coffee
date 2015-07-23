express = require('express')
router = express.Router()
parser = require('xml2json')

KEY = 'Q2VM-JDUP-IMPQ-DT35'

router.get '/', (req, res, next) ->
  # http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&key=MW9S-E7SL-26DU-VV8V&dir=s
  xml = "<foo>bar</foo>"
  json = parser.toJson(xml) # returns a string containing the JSON structure by default
  console.log(json)
  res.send('respond with a resource')


module.exports = router
