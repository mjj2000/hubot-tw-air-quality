# Description:
#   Commands to query air quality data of Taiwan
#
# Commands:
#   hubot tw-air:<data-name> <city> - Query a specified data by city

module.exports = (robot) ->

  robot.hear /tw-air:(\S+)\s+(\S+)/i, (res) ->
    twAirQuality = require('tw-air-quality');
    _ = require "lodash";
    type = _.capitalize(res.match[1].toLowerCase())
    city = res.match[2]
    method = "query#{type}ByCity"
    if method of twAirQuality
      twAirQuality[method](
        city,
        (value) ->
          res.reply "#{type}: #{value}",
        (err) ->
          res.reply "#{err.message}"
      )
    else
      res.reply """
                Invalid query type. Available data types:
                  Status, Pm25, Pm10, So2, Co, O3, No2, WindSpeed, WindDirec, Fpmi, Nox, No
                """
