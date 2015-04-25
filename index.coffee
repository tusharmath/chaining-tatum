_ = require 'lodash'
Q = require 'q'
_ = require 'lodash'

class PipeFactory
    constructor: ->
        @_items = []
    pipe: (cb) ->
        @_items.push cb
        @
    _callItems: (memory, item) =>
        if memory?.then
            memory.then (val) => @_callItems val, item
        else if memory instanceof Array
            Q.all _.map memory, (i) =>  @_callItems i, item
        else
            Q item memory

    launch: (start=null) ->
        _.reduce @_items, @_callItems, start

class ChainFactory
    create: (proto) ->
        piper = new PipeFactory
        obj = $launch: (start) -> piper.launch start
        _.each proto, (val, key) ->
            obj[key] = (args1...) ->
                piper.pipe (args2...) ->
                    val args1..., args2...
                obj
        obj

module.exports = {ChainFactory, PipeFactory}
