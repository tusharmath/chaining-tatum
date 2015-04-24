Q = require 'q'
_ = require 'lodash'
class Piper
    constructor: (@start = null) ->
        @_items = []
    pipe: (cb) ->
        @_items.push cb
        @
    _callItems: (memory, item) =>
        # console.log 'y'
        if memory?.then
            memory.then (val) => @_callItems val, item
        else if memory instanceof Array
            Q.all _.map memory, (i) =>  @_callItems i, item
        else
            Q item memory

    launch: (cb) ->
        _.reduce @_items, @_callItems, @start
        .then (val) -> cb val
        .done()

module.exports = Piper