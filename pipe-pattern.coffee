Q = require 'q'
_ = require 'lodash'
class Piper
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

module.exports = Piper