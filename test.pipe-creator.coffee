sinon = require 'sinon'
PipeCreator = require './pipe-creator'
describe "PipeCreator()", ->
    beforeEach ->
        @mod = new PipeCreator

    it "is chainable", ->
        obj = a: sinon.spy()
        @mod.create(obj).a().a().a()
    it "pipes", ->
        obj = a: (memory, data) ->
            memory + 1 + data
        fake = @mod.create(obj)
        fake.a(10).a(20).a(30)
        fake.$launch(1000)
        .should.eventually.equal 1063
