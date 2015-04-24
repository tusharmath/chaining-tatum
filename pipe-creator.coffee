_ = require 'lodash'
Piper = require './pipe-pattern'
class PipeCreator

    create: (proto) ->
        piper = new Piper
        obj = $launch: (start) -> piper.launch start
        _.each proto, (val, key) ->
            obj[key] = (args1...) ->
                piper.pipe (args2...) ->
                    val args1..., args2...
                obj
        obj

module.exports = PipeCreator